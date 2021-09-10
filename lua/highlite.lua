--[[ NOTHING INSIDE THIS FILE NEEDS TO BE EDITED BY THE USER. ]]

--- A Neovim plugin to create more straightforward syntax for Lua `:map`ping and `:unmap`ping.
--- @module nvim-cartographer
--- @alias highlite table

--[[/* VARS */]]

--- Which set of colors to use.
local _USE_256 = tonumber(vim.go.t_Co) > 255 or string.find(vim.env.TERM, '256')

--- Indicating nothing for a highlight field.
local _NONE = 'NONE'

--- Which index to use for `cterm` highlights.
local _PALETTE_CTERM = _USE_256 and 2 or 3

--- Which index to use for `gui` highlights.
local _PALETTE_HEX  = 1

--- The `string` type.
local _TYPE_STRING = 'string'

--- The `table` type.
local _TYPE_TABLE  = 'table'

--[[/* HELPER FUNCTIONS */]]

--- Filter out information not pertaining to styles
--- @param key string the field from `nvim_get_hl_by_name`
--- @return boolean should_not_filter `true` if the field should not be filtered
local function filter_group_style(key)
	return key ~= 'background'
		and key ~= 'blend'
		and key ~= 'foreground'
		and key ~= 'special'
end

--- @param color string|table the color name or definition
--- @param index number
--- @return number|string color_value a hex, 16-bit, or ANSI color. "NONE" by default
local function get(color, index) -- {{{ †
	if type(color) == _TYPE_TABLE and color[index] then
		return color[index]
	elseif type(color) == _TYPE_STRING then
		return color
	end

	return _NONE
end --}}} ‡

--- Take a `command` and add color-specifying components to it.
--- @param command table the in-progress `:highlight` command
--- @param definition table the definition of the highlight group
local function colorize(command, definition) -- {{{ †
	command[#command+1]=' guibg='..get(definition.bg, _PALETTE_HEX)..' guifg='..get(definition.fg, _PALETTE_HEX)
		..' ctermbg='..get(definition.bg, _PALETTE_CTERM)..' ctermfg='..get(definition.fg, _PALETTE_CTERM)

	-- Add the `blend` parameter if it is present
	if definition.blend then -- There is a value for the `highlight-blend` field.
		command[#command+1]=' blend='..definition.blend
	end
end --}}} ‡

--- This function appends `selected_definition` to the end of `highlight_cmd`.
--- @param command table the in-progress `:highlight` command
--- @param style string the `gui`/`cterm` arguments to apply
--- @param color string|table a `guisp` argument; same arg as `get`
--- @see get
local function stylize(command, style, color)
	command[#command+1]=' gui='..style..' cterm='..style

	if color then -- There is an undercurl color.
		command[#command+1]=' guisp='..get(color, _PALETTE_HEX)
	end
end

--- @param rgb string some string of RGB colors.
--- @return string hex
local function tohex(rgb) return string.format('#%06x', rgb) end

--- Create a metatable which prioritizes entries in the `&bg` index of `definition`
--- @param definition table the definition of the highlight group
--- @return table
local function use_background_with(definition)
	return setmetatable(definition[vim.go.background], {__index = definition})
end

--[[/* MODULE */]]

local highlite = {}

--- @param group_name string
--- @return table definition a nvim-highlite compliant table describing `group_name`
function highlite.group(group_name)
	local no_errors, group_definition = pcall(vim.api.nvim_get_hl_by_name, group_name, vim.go.termguicolors)

	if not no_errors then group_definition = {} end

	-- the style of the highlight group
	local style = vim.tbl_filter(filter_group_style, vim.tbl_keys(group_definition))
	if group_definition.special then
		style.color = tohex(group_definition.special)
	end

	return
	{
		fg = group_definition.foreground and tohex(group_definition.foreground) or _NONE,
		bg = group_definition.background and tohex(group_definition.background) or _NONE,
		blend = group_definition.blend,
		style = style or _NONE
	}
end

-- Generate a `:highlight` command from a group and some definition.

--- Generate and execute `:highlight` command from a group and some definition.
--- @param highlight_group string the `{group-name}` argument for `:highlight`
--- @param definition string|table a link or an attribute map
function highlite.highlight(highlight_group, definition) -- {{{ †
	if type(definition) == _TYPE_STRING then -- `highlight_group` is a link to another group.
		vim.api.nvim_command('hi! link '..highlight_group..' '..definition)
		return
	end

	-- The base highlight command
	local highlight_cmd = {'hi! ', highlight_group}

	-- Take care of special instructions for certain background colors.
	if definition[vim.go.background] then
		definition = use_background_with(definition)
	end

	colorize(highlight_cmd, definition)

	local style = definition.style or _NONE

	if type(style) == _TYPE_TABLE then
		-- Concat all of the entries together with a comma between before styling.
		stylize(highlight_cmd, table.concat(style, ','), style.color)
	else -- The style is just a single entry.
		stylize(highlight_cmd, style)
	end

	vim.api.nvim_command(table.concat(highlight_cmd))
end --}}} ‡

--- Set `g:terminal_color_`s based on `terminal_colors`.
--- @param terminal_colors table a list 1..16 of colors to use in the terminal
function highlite:highlight_terminal(terminal_colors)
	for index, color in ipairs(terminal_colors) do vim.g['terminal_color_'..(index-1)] =
		vim.go.termguicolors and color[_PALETTE_HEX] or color[_PALETTE_CTERM]
	end
end

return setmetatable(highlite, {__call = function(self, normal, highlights, terminal_colors)
	--- resolve highlight groups being defined by function calls.
	--- @param tbl table the current table being indexed.
	--- @param key string the key to resolve the value for.
	--- @param resolve_links boolean whether to translate highlight links into full values
	--- @returns the value at `tbl[key]`, when highlight links and embedded functions have been accounted for.
	local function resolve(tbl, key, resolve_links)
		local value = tbl[key]
		local value_type = type(value)

		if value_type == 'function' then -- call and cache the result; next time, if it isn't a function this step will be skipped
			tbl[key] = value(setmetatable({},
			{
				__index = function(_, inner_key) return resolve(tbl, inner_key, true) end
			}))
		elseif resolve_links and value_type == _TYPE_STRING and not string.find(value, '^#') then
			return resolve(tbl, value, resolve_links)
		end

		return tbl[key]
	end

	-- save the colors_name before syntax reset
	local color_name = vim.g.colors_name

	-- If the syntax has been enabled, reset it.
	if vim.fn.exists 'syntax_on' then vim.api.nvim_command 'syntax reset' end

	-- replace the colors_name
	vim.g.colors_name = color_name
	color_name = nil

	-- If we aren't using hex nor 256 colorsets.
	if not (vim.go.termguicolors or _USE_256) then vim.go.t_Co = '16' end

	-- Highlight the baseline.
	self.highlight('Normal', normal)

	-- Highlight everything else.
	for highlight_group, _ in pairs(highlights) do
		self.highlight(highlight_group, resolve(highlights, highlight_group, false))
	end

	-- Set the terminal highlight colors.
	self:highlight_terminal(terminal_colors)
end})
