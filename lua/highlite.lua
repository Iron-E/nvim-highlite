--[[ NOTHING INSIDE THIS FILE NEEDS TO BE EDITED BY THE USER. ]]

--[[
	/*
	 * IMPORTS
	 */
--]]

local vim = vim
local api = vim.api
local cmd = api.nvim_command
local fn  = vim.fn

--[[
	/*
	 * VARS
	 */
--]]

-- These are constants for the indexes in the colors that were defined before.
local _NONE = 'NONE'
local _PALETTE_256  = 2
local _PALETTE_ANSI = 3
local _PALETTE_HEX  = 1
local _TYPE_STRING = 'string'
local _TYPE_TABLE  = 'table'

-- Determine which set of colors to use.
local _USING_HEX_OR_256 = tonumber(vim.o.t_Co) >= 256
	or vim.o.termguicolors
	or string.find(vim.env.TERM, '256')

--[[
	/*
	 * HELPER FUNCTIONS
	 */
--]]

-- Add the 'blend' parameter to some highlight command, if there is one.
local function blend(command, attributes) -- {{{ †
	if attributes.blend then -- There is a value for the `highlight-blend` field.
		command[#command + 1] = ' blend='..attributes.blend
	end
end --}}} ‡

-- Get the color value of a color variable, or "NONE" as a default.
local function get(color, index) -- {{{ †
	if type(color) == _TYPE_TABLE and color[index] then
		return color[index]
	elseif type(color) == _TYPE_STRING then
		return color
	else
		return _NONE
	end
end --}}} ‡

--[[ If using hex and 256-bit colors, then populate the gui* and cterm* args.
	If using 16-bit colors, just populate the cterm* args. ]]
local colorize = _USING_HEX_OR_256 and function(command, attributes) -- {{{ †
	command[#command + 1] =
		' ctermbg='..get(attributes.bg, _PALETTE_256)
		..' ctermfg='..get(attributes.fg, _PALETTE_256)
		..' guibg='..get(attributes.bg, _PALETTE_HEX)
		..' guifg='..get(attributes.fg, _PALETTE_HEX)
	blend(command, attributes)
end or function(command, attributes)
	command[#command + 1] =
		' ctermbg='..get(attributes.bg, _PALETTE_ANSI)
		..' ctermfg='..get(attributes.fg, _PALETTE_ANSI)
	blend(command, attributes)
end --}}} ‡

-- Detect attribute links and link them
local _HIGHLITE_NVIM_API_MAP = {
	bg = 'background',
	fg = 'foreground',
	blend = 'blend',
	style = {
		'special',
		'reverse',
		'italic',
		'bold',
		'strikethrough',
		'underline',
		'undercurl',
	},
}

-- link the colors of a highlight group.
local function link_color_attribute(unlinked_attributes, unlinked_attribute, attribute_from_group_to_link)
	unlinked_attributes[unlinked_attribute] = (attribute_from_group_to_link and vim.o.termguicolors)
		and string.format('#%06x', attribute_from_group_to_link)
		or attribute_from_group_to_link
		or _NONE
end

-- link the style of a highlight group.
local function link_style_attributes(unlinked_attributes, unlinked_attribute, attributes_to_link, group_to_link)
	unlinked_attributes[unlinked_attribute] = {}

	for _, attribute_to_link in ipairs(attributes_to_link) do
		if group_to_link[attribute_to_link] then
			unlinked_attributes[unlinked_attribute][#unlinked_attributes[unlinked_attribute] + 1] = attribute_to_link
		end
	end
end

-- link attributes in a highlight group.
local function link_attributes(unlinked_attributes)
	for unlinked_attribute, unlinked_value in pairs(unlinked_attributes) do
		if type(unlinked_value) == _TYPE_STRING then

			local attributes_to_link = _HIGHLITE_NVIM_API_MAP[unlinked_attribute]
			local group_to_link = api.nvim_get_hl_by_name(unlinked_value, vim.o.termguicolors) or {}
			local link_type = type(attributes_to_link)

			if link_type == _TYPE_STRING then
				link_color_attribute(unlinked_attributes, unlinked_attribute, group_to_link[attributes_to_link])
			elseif link_type == _TYPE_TABLE then
				link_style_attributes(unlinked_attributes, unlinked_attribute, attributes_to_link, group_to_link)
			else -- it is a number
				unlinked_attributes[unlinked_attribute] = attributes_to_link
			end
		end
	end
end

-- This function appends `selected_attributes` to the end of `highlight_cmd`.
local stylize = _USING_HEX_OR_256 and function(command, style, color) -- {{{ †
	command[#command + 1] = ' cterm='..style..' gui='..style

	if color then -- There is an undercurl color.
		command[#command + 1] = ' guisp='..get(color, _PALETTE_HEX)
	end
end or function(command, style)
	command[#command + 1] = ' cterm='..style
end --}}} ‡

-- Load specific &bg instructions
local function use_background_with(attributes)
	attributes.__index = attributes
	return setmetatable(attributes[vim.o.background], attributes)
end

--[[
	/*
	 * MODULE
	 */
--]]

local highlite = {}

-- Generate a `:highlight` command from a group and some attributes.
function highlite.highlight(highlight_group, attributes) -- {{{ †
	-- The base highlight command
	local highlight_cmd = {'hi! ', highlight_group}

	-- Take care of special instructions for certain background colors.
	if attributes[vim.o.background] then
		attributes = use_background_with(attributes)
	end

	-- Determine if there is a highlight link, and if so, assign it.
	local link = (type(attributes) == _TYPE_STRING) and attributes

	if link then -- `highlight_group` is a link to another group.
		highlight_cmd[3] = highlight_cmd[2]
		highlight_cmd[2] = 'link '
		highlight_cmd[4] = ' '
		highlight_cmd[5] = link
	else -- The `highlight_group` is uniquely defined.
		link_attributes(attributes)
		colorize(highlight_cmd, attributes)

		local style = attributes.style or _NONE
		if type(style) == _TYPE_TABLE then
			-- Concat all of the entries together with a comma between before styling.
			stylize(highlight_cmd, table.concat(style, ','), style.color)
		else -- The style is just a single entry.
			stylize(highlight_cmd, style)
		end
	end

	cmd(table.concat(highlight_cmd))
end --}}} ‡

function highlite:highlight_terminal(terminal_ansi_colors)
	if self.using_hex_or_256 then for index, color in ipairs(terminal_ansi_colors) do
		vim.g['terminal_color_'..index] = vim.o.termguicolors and color[_PALETTE_HEX] or color[_PALETTE_256]
	end end
end

return setmetatable(highlite, {
	['__call'] = function(self, normal, highlights, terminal_ansi_colors)
		-- Clear the highlighting.
		cmd('hi clear')

		-- If the syntax has been enabled, reset it.
		if fn.exists('syntax_on') then cmd('syntax reset') end

		-- If we aren't using hex nor 256 colorsets.
		if not _USING_HEX_OR_256 then vim.o.t_Co = 16 end

		-- Highlight the baseline.
		self.highlight('Normal', normal)

		-- Highlight everything else.
		for highlight_group, attributes in pairs(highlights) do
			self.highlight(highlight_group, attributes)
		end

		-- Set the terminal highlight colors.
		self:highlight_terminal(terminal_ansi_colors)
	end
})
