--[[ NOTHING INSIDE THIS FILE NEEDS TO BE EDITED BY THE USER. ]]
local vim = vim

-- Clear the highlighting.
vim.cmd('hi clear')

-- Set the background to dark.
vim.o.background = 'dark'

-- Disable automatic coloring for the IndentGuides plugin.
vim.g.indent_guides_auto_colors = 0

-- If the syntax has been enabled, reset it.
if vim.fn.exists('syntax_on') then vim.cmd('syntax reset') end

-- Determine which set of colors to use.
local use_hex_and_256 = string.find(vim.fn.expand('$TERM'), '256')
	or vim.g.t_Co >= 256
	or vim.fn.has('gui_running')

-- If we aren't using the hex and 256 colorset, then set the &t_Co variable to 16.
if not use_hex_and_256 then vim.g.t_Co = 16 end

-- These are constants for the indexes in the colors that were defined before.
local BIT_16  = 3
local BIT_256 = 2
local HEX     = 1

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

--[[ If using hex and 256-bit colors, then populate the gui* and cterm* args.
	If using 16-bit colors, just populate the cterm* args. ]]
local colorize = use_hex_and_256 and function(command, attributes) command[#command + 1] =
	' ctermbg='..get(attributes.bg, BIT_256)
	..' ctermfg='..get(attributes.fg, BIT_256)
	..' guibg='..get(attributes.bg, HEX)
	..' guifg='..get(attributes.fg, HEX)
end or function(command, attributes) command[#command + 1] =
	' ctermbg='..get(attributes.bg, BIT_16)
	..' ctermfg='..get(attributes.fg, BIT_16)
end

-- This function appends `selected_attributes` to the end of `highlight_cmd`.
local stylize = use_hex_and_256 and function(command, attributes)
	command[#command + 1] = ' cterm='..attributes..' gui='..attributes
end or function(command, attributes)
	command[#command + 1] = ' cterm='..attributes
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

		if attributes.blend then -- There is a value for the `highlight-blend` field.
			highlight_cmd[#highlight_cmd + 1] = ' blend='..attributes.blend
		end

		local style = attributes.style
		if type(style) == 'table' then
			-- Concat all of the entries together with a comma between before styling.
			stylize(highlight_cmd, table.concat(style, ','))

			if style.color then -- there won't is a color for undercurl.
				highlight_cmd[#highlight_cmd + 1] = ' guisp='..get(style.color, HEX)
			end
		else -- just style the single entry.
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
	for index, color in ipairs(terminal_ansi_colors) do
		vim.g['terminal_color_'..index] = color[HEX] or color[BIT_256] or color[BIT_16]
	end
end
