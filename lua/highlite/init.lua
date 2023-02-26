--[[ NOTHING INSIDE THIS FILE NEEDS TO BE EDITED BY THE USER. ]]

--[[/* Vars */]]

--- Which set of colors to use.
local USE_256 = tonumber(vim.api.nvim_get_option 't_Co') > 255 or vim.env.TERM:find '256'

--- Which index to use for `cterm` highlights.
local PALETTE_CTERM = USE_256 and 2 or 3

--- Which index to use for `gui` highlights.
local PALETTE_HEX = 1

--[[/* Helper Functions */]]

--- resolve highlight groups being defined by function calls.
--- @param groups highlite.groups the current table being indexed.
--- @param key string the key to resolve the value for.
--- @param resolve_links boolean iff `true`, further `resolve` `highlight.group.link`s to their original `highlite.group.new`s
--- @return highlite.group.definition # the value at `tbl[key]`, when highlight links and embedded functions have been accounted for.
local function resolve(groups, key, resolve_links) -- {{{
	local original_group = groups[key]

	if type(original_group) == 'function' then
		-- PERF: the result of the function call is assigned to its associated index.
		--       next time it is accessed, there will be no need to call the function again.
		groups[key] = original_group(setmetatable({}, {
			__index = function(_, inner_key) return resolve(groups, inner_key, true) end
		}))
	elseif resolve_links and original_group.link then
		return resolve(groups, original_group.link, resolve_links)
	end

	--- @diagnostic disable-next-line:return-type-mismatch the `fun(self: highlight.groups)` was already called
	return groups[key]
end -- }}}

--[[/* Module */]]

--- A Neovim plugin to create more straightforward syntax for Lua `:map`ping and `:unmap`ping.
--- @class highlite
local highlite = {}

--- @param name string the name of the highlight group
--- @return highlite.group.definition definition an nvim-highlite compliant table describing the highlight group `name`
function highlite.group(name)
	local ok, definition = pcall(vim.api.nvim_get_hl_by_name, name, vim.api.nvim_get_option 'termguicolors')
	if not ok then
		return {}
	end

	for input, output in pairs {background = 'bg', foreground = 'fg', special = 'sp'} do
		if definition[input] then
			definition[output] = string.format('#%06x', definition[input])
			definition[input] = nil
		end
	end

	return definition
end

--- `nvim_set_hl` using the `name` and `definition`
--- @param name string the name of the highlight group
--- @param definition highlite.group.definition a link or an attribute map
function highlite.highlight(name, definition) -- {{{
	local highlight = {} --- @type highlite.group.nvim_api

	if definition.link then -- `highlight_group` is a link to another group.
		highlight.link = definition.link
	else
		--- @diagnostic disable-next-line:param-type-mismatch we *just* checked that it is a table
		for k, v in pairs(definition) do
			highlight[k] = v
		end

		-- These fields don't exist in `nvim_set_hl`, so clear them
		highlight.dark = nil
		highlight.light = nil

		--- @type highlite.group.definition
		local bg_definition = definition[vim.api.nvim_get_option 'background']
		if bg_definition then
			for k, v in pairs(bg_definition) do
				highlight[k] = v
			end
		end

		highlight.ctermbg = highlight.bg and highlight.bg[PALETTE_CTERM]
		highlight.ctermfg = highlight.fg and highlight.fg[PALETTE_CTERM]

		highlight.bg = highlight.bg and highlight.bg[PALETTE_HEX]
		highlight.fg = highlight.fg and highlight.fg[PALETTE_HEX]
		highlight.sp = highlight.sp and highlight.sp[PALETTE_HEX]
	end

	vim.api.nvim_set_hl(0, name, highlight)
end --}}}

--- `highlite.highlight` all of the `groups`
--- @param groups highlite.groups
--- @see highlite.highlight
function highlite.highlight_all(groups)
	for name, _ in pairs(groups) do
		highlite.highlight(name, resolve(groups, name, false))
	end
end

--- Set `g:terminal_color_`s based on `terminal_colors`.
--- @param terminal_colors table a list 1..16 of colors to use in the terminal
function highlite.highlight_terminal(terminal_colors)
	for index, color in ipairs(terminal_colors) do
		vim.api.nvim_set_var('terminal_color_' .. (index - 1), color[
			vim.api.nvim_get_option 'termguicolors' and PALETTE_HEX or PALETTE_CTERM
		])
	end
end

return highlite
