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

-- Generate a `:highlight` command from a group and some attributes.
local function highlight(highlight_group, attributes) -- {{{ †
	local highlight_cmd = {'hi! ', highlight_group}
	local link = attributes.link

	-- If the `highlight_group` is a link to another group.
	if attributes.link then
		highlight_cmd[3] = highlight_cmd[2] .. ' '
		highlight_cmd[2] = 'link '
		highlight_cmd[4] = attributes.link
	else -- the `highlight_group` is uniquely defined.
		local bg    = attributes.bg
		local fg    = attributes.fg
		local style = attributes.style

		-- If using hex and 256-bit colors, then populate the gui* and cterm* args.
		if use_hex_and_256 then highlight_cmd[#highlight_cmd + 1] =
			' ctermbg=' .. get(bg, BIT_256)
			.. ' ctermfg=' .. get(fg, BIT_256)
			.. ' guibg='   .. get(bg, HEX)
			.. ' guifg='   .. get(fg, HEX)
		-- If using 16-bit colors, just populate the cterm* args.
		else highlight_cmd[#highlight_cmd + 1] =
			' ctermbg=' .. get(bg, BIT_16)
			.. ' ctermfg=' .. get(fg, BIT_16)
		end

		-- This function appends `selected_attributes` to the end of the `highlight_cmd`.
		local function append_style(selected_attributes)
			highlight_cmd[#highlight_cmd + 1] = ' cterm=' .. selected_attributes

			-- If we're using hex populate the gui* attr args.
			if use_hex_and_256 then highlight_cmd[#highlight_cmd + 1] =
				' gui=' .. selected_attributes
			end
		end

		if type(style) == 'table' then
			-- Concat all of the entries together with a comma between.
			local style_all = table.concat(style, ',')

			-- There will always be a cterm attr arg.
			append_style(style_all)

			-- There won't always be a `guisp`.
			if style.color then highlight_cmd[#highlight_cmd + 1] =
				' guisp=' .. get(style.color, HEX)
			end
		else append_style(style)
		end
	end

	vim.cmd(table.concat(highlight_cmd))
end --}}} ‡

return function(name, Normal, highlights, terminal_ansi_colors)
	-- Set the name of the current colorscheme.
	vim.g.colors_name = string.lower(name)

	-- Highlight the baseline.
	highlight('Normal', Normal)

	-- Highlight everything else.
	for highlight_group, attributes in pairs(highlights) do
		highlight(highlight_group, attributes)
	end

	-- Set the terminal colors.
	for index, color in ipairs(terminal_ansi_colors) do
		vim.g['terminal_color_' .. index] = get(color, HEX)
	end
end
