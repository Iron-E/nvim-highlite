--[[ NOTHING INSIDE THIS FILE NEEDS TO BE EDITED BY THE USER. ]]

--[[/* Vars */]]

--- Which set of colors to use.
local USE_256 = tonumber(vim.api.nvim_get_option 't_Co') > 255 or vim.loop.os_getenv('TERM'):find '256'

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
	local original_group = rawget(groups, key)
	local original_group_type = type(original_group)

	if original_group_type == 'function' then
		local resolved = original_group(setmetatable({}, {__index = function(_, inner_key)
			return resolve(groups, inner_key, true)
		end}))

		-- PERF: assign the result of the function call to its associated index so that
		--       the function will not need to be called again on subsequent accesses.
		rawset(groups, key, resolved)

		return resolved
	elseif resolve_links then
		if original_group_type == 'string'  then
			return resolve(groups, original_group, resolve_links)
		elseif original_group.link then
			return resolve(groups, original_group.link, resolve_links)
		end
	end

	return original_group
end -- }}}

--[[/* Module */]]

--- A Neovim plugin to create more straightforward syntax for Lua `:map`ping and `:unmap`ping.
--- @class highlite
local highlite = {}

highlite.group = vim.api.nvim_get_hl and
	--- @param name string the name of the highlight group
	--- @param link boolean if `true`, return highlight links instead of the true definition
	--- @return highlite.group.new definition an nvim-highlite compliant table describing the highlight group `name`
	function(name, link)
		local definition = vim.api.nvim_get_hl(0, {link = link or false, name = name})

		for gui, cterm in pairs {bg = 'ctermbg', fg = 'ctermfg', sp = vim.NIL} do
			definition[gui] = {[PALETTE_CTERM] = definition[cterm], [PALETTE_HEX] = definition[gui]}
			definition[cterm] = nil
		end

		return definition
	end or
	--- @param name string the name of the highlight group
	--- @return highlite.group.new definition an nvim-highlite compliant table describing the highlight group `name`
	function(name)
		local ok, definition = pcall(vim.api.nvim_get_hl_by_name, name, true)
		local _, cterm = pcall(vim.api.nvim_get_hl_by_name, name, false)

		if not ok then
			return {}
		end

		for input, output in pairs {background = 'bg', foreground = 'fg', special = 'sp'} do
			local definition_input = definition[input]
			if definition_input then
				definition[output] = {[PALETTE_CTERM] = cterm[input], [PALETTE_HEX] = definition_input}
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
	if type(definition) == 'string' then -- `definition` is a shorthand link; most common
		highlight.link = definition
	elseif not definition.link then -- `definition` is a new group; second-most common
		for k, v in pairs(definition) do
			highlight[k] = v
		end

		-- These fields don't exist in `nvim_set_hl`, so clear them
		highlight.dark = nil
		highlight.light = nil

		local background = vim.api.nvim_get_option 'background' --- @type 'light'|'dark'
		local background_definition = definition[background]
		if background_definition then
			for k, v in pairs(background_definition) do
				highlight[k] = v
			end
		end

		highlight.ctermbg = highlight.bg and highlight.bg[PALETTE_CTERM]
		highlight.ctermfg = highlight.fg and highlight.fg[PALETTE_CTERM]

		highlight.bg = highlight.bg and highlight.bg[PALETTE_HEX]
		highlight.fg = highlight.fg and highlight.fg[PALETTE_HEX]
		highlight.sp = highlight.sp and highlight.sp[PALETTE_HEX]
	else -- Nvim API-style highlight link; least common
		highlight.link = definition.link
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
--- @param terminal_colors highlite.color.definition[] a list 1..16 of colors to use in the terminal
function highlite.highlight_terminal(terminal_colors)
	for index, color in ipairs(terminal_colors) do
		vim.api.nvim_set_var('terminal_color_' .. (index - 1), color[
			vim.api.nvim_get_option 'termguicolors' and PALETTE_HEX or PALETTE_CTERM
		])
	end
end

return highlite
