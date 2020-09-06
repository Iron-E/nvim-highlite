--[[ NOTHING INSIDE THIS FILE NEEDS TO BE EDITED BY THE USER. ]]
local vim = vim

-- Clear the highlighting.
vim.cmd('hi clear')

-- Disable automatic coloring for the IndentGuides plugin.
vim.g.indent_guides_auto_colors = 0

-- If the syntax has been enabled, reset it.
if vim.fn.exists('syntax_on') then vim.cmd('syntax reset') end

-- Determine which set of colors to use.
local using_hex_or_256 = tonumber(vim.o.t_Co) >= 256
	or vim.o.termguicolors
	or vim.fn.has('gui_running')
	or string.find(vim.fn.expand('$TERM'), '256')

-- If we aren't using the hex and 256 colorset, then set the &t_Co variable to 16.
if not using_hex_or_256 then vim.o.t_Co = 16 end

-- These are constants for the indexes in the colors that were defined before.
local PALETTE_ANSI = 3
local PALETTE_256  = 2
local PALETTE_HEX  = 1

-- Get the color value of a color variable, or "NONE" as a default.
local function get(color, index)
	if type(color) == 'table' and color[index] then
		return color[index]
	elseif type(color) == 'string' then
		return color
	else
		return "NONE"
	end
end

-- Add the 'blend' parameter to some highlight command, if there is one.
local function blend(command, attributes)
	if attributes.blend then -- There is a value for the `highlight-blend` field.
		command[#command + 1] = ' blend='..attributes.blend
	end
end

--[[ If using hex and 256-bit colors, then populate the gui* and cterm* args.
	If using 16-bit colors, just populate the cterm* args. ]]
local colorize = using_hex_or_256 and function(command, attributes)
	command[#command + 1] =
		' ctermbg='..get(attributes.bg, PALETTE_256)
		..' ctermfg='..get(attributes.fg, PALETTE_256)
		..' guibg='..get(attributes.bg, PALETTE_HEX)
		..' guifg='..get(attributes.fg, PALETTE_HEX)
	blend(command, attributes)
end or function(command, attributes)
	command[#command + 1] =
		' ctermbg='..get(attributes.bg, PALETTE_ANSI)
		..' ctermfg='..get(attributes.fg, PALETTE_ANSI)
	blend(command, attributes)
end

-- This function appends `selected_attributes` to the end of `highlight_cmd`.
local stylize = using_hex_or_256 and function(command, style, color)
	command[#command + 1] = ' cterm='..style..' gui='..style

	if color then -- There is an undercurl color.
		command[#command + 1] = ' guisp='..get(color, PALETTE_HEX)
	end
end or function(command, style)
	command[#command + 1] = ' cterm='..style
end

-- Generate a `:highlight` command from a group and some attributes.
local function highlight(highlight_group, attributes) -- {{{ †
	local highlight_cmd = {'hi! ', highlight_group}
	local link = (type(attributes) == 'string' and attributes)
		or attributes.link

	if link then -- `highlight_group` is a link to another group.
		highlight_cmd[3] = highlight_cmd[2]..' '
		highlight_cmd[2] = 'link '
		highlight_cmd[4] = link
	else -- The `highlight_group` is uniquely defined.
		colorize(highlight_cmd, attributes)

		local style = attributes.style
		if type(style) == 'table' then
			-- Concat all of the entries together with a comma between before styling.
			stylize(highlight_cmd, table.concat(style, ','), style.color)
		elseif style then -- just style the single entry.
			stylize(highlight_cmd, style)
		end
	end

	vim.cmd(table.concat(highlight_cmd))
end --}}} ‡

return function(Normal, highlights, terminal_ansi_colors)
	-- Highlight the baseline.
	highlight('Normal', Normal)

	-- Highlight everything else.
	for highlight_group, attributes in pairs(highlights) do
		highlight(highlight_group, attributes)
	end

	-- Set the terminal colors.
	if using_hex_or_256 then for index, color in ipairs(terminal_ansi_colors) do
		vim.g['terminal_color_'..index] = vim.o.termguicolors and color[PALETTE_HEX] or color[PALETTE_256]
	end end
end
