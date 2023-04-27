local Fmt = require 'highlite.fmt' --- @type highlite.Fmt
local Fs = require 'highlite.fs' --- @type highlite.Fs
local Util = require 'highlite.utils' --- @type highlite.Utils

--- @class highlite.Export
local Export = {}

--- @class highlite.export.options: highlite.Fs.write.opts
--- @field dir? string the output directory
--- @field filename? string the name of the file without an extension

--- @alias highlite.export.format async fun(colorscheme: string, opts?: highlite.export.options, dir_DEPRECATED?: string)

do
	local FMT = [[
local g = vim.g
local hl = vim.api.nvim_set_hl

vim.api.nvim_command 'highlight clear'
if vim.api.nvim_get_option 'background' == 'dark' then%s%s
else%s%s
end

vim.api.nvim_set_var('colors_name', %s)
]]

	--- @return string
	local function fmt_groups()
		local s = ''
		for group, definition in pairs(vim.api.nvim_get_hl(0, {})) do
			-- Skip nvim-colorizer, nvim-web-devicons, and heirline
			if not (group:find '^colorizer_' or group:find '^DevIcon' or group:find '^Stl_?[1-9a-f]*') then
				s = s .. "\n\thl(0, '" .. group .. "', " .. vim.inspect(definition, {indent = '', newline = ' '}) .. ')'
			end
		end

		return s
	end

	--- @return string
	local function fmt_terminal()
		return '\n\tg.terminal_color_0 = ' .. vim.inspect(vim.g.terminal_color_0) ..
			'\n\tg.terminal_color_1 = ' .. vim.inspect(vim.g.terminal_color_1) ..
			'\n\tg.terminal_color_2 = ' .. vim.inspect(vim.g.terminal_color_2) ..
			'\n\tg.terminal_color_3 = ' .. vim.inspect(vim.g.terminal_color_3) ..
			'\n\tg.terminal_color_4 = ' .. vim.inspect(vim.g.terminal_color_4) ..
			'\n\tg.terminal_color_5 = ' .. vim.inspect(vim.g.terminal_color_5) ..
			'\n\tg.terminal_color_6 = ' .. vim.inspect(vim.g.terminal_color_6) ..
			'\n\tg.terminal_color_7 = ' .. vim.inspect(vim.g.terminal_color_7) ..
			'\n\tg.terminal_color_8 = ' .. vim.inspect(vim.g.terminal_color_8) ..
			'\n\tg.terminal_color_9 = ' .. vim.inspect(vim.g.terminal_color_9) ..
			'\n\tg.terminal_color_10 = ' .. vim.inspect(vim.g.terminal_color_10) ..
			'\n\tg.terminal_color_11 = ' .. vim.inspect(vim.g.terminal_color_11) ..
			'\n\tg.terminal_color_12 = ' .. vim.inspect(vim.g.terminal_color_12) ..
			'\n\tg.terminal_color_13 = ' .. vim.inspect(vim.g.terminal_color_13) ..
			'\n\tg.terminal_color_14 = ' .. vim.inspect(vim.g.terminal_color_14) ..
			'\n\tg.terminal_color_15 = ' .. vim.inspect(vim.g.terminal_color_15)
	end

	--- NOTE: this function strips out leading dots from colorscheme names, e.g. `.foo` → `foo`.
	---       You can use this to create a bootstrap custom colorscheme in `colors/.custom.lua` and it will get written
	---       to `colors/custom.lua`.
	--- @type highlite.export.format
	function Export.nvim(colorscheme, opts, dir)
		if opts == nil then opts = {} end

		-- checked for backwards compatability
		if dir == nil then
			dir = opts.dir or vim.fn.stdpath('config') .. '/colors/'
		end

		dir = vim.fs.normalize(dir)
		local filename = opts.filename or colorscheme
		local previous_bg = vim.api.nvim_get_option 'background' --- @type highlite.bg
		local previous_colorscheme = vim.api.nvim_get_var 'colors_name'

		Util.switch_colorscheme(colorscheme)
		vim.api.nvim_set_option('background', 'dark')
		local dark_groups = fmt_groups()
		local dark_terminal = fmt_terminal()

		vim.api.nvim_set_option('background', 'light')
		local light_groups = fmt_groups()
		local light_terminal = fmt_terminal()

		Util.switch_colorscheme(previous_colorscheme)
		vim.api.nvim_set_option('background', previous_bg)

		Fs.write(
			dir .. '/' .. filename .. '.lua',
			FMT:format(dark_groups, dark_terminal, light_groups, light_terminal, filename),
			opts
		)
	end
end

do
	local FMT = [["
origin_url = 'https://github.com/Iron-E/nvim-highlite'

[colors]
background = ${Normal.bg}
foreground = ${Normal.fg}

cursor_bg = ${Cursor.bg}
cursor_border = ${Cursor.bg}
cursor_fg = ${Cursor.fg}

selection_bg = ${Visual.bg}
selection_fg = ${Visual.fg}

scrollbar_thumb = ${PmenuThumb.fg | PmenuThumb.bg}

split = ${WinSeparator.fg | WinSeparator.bg}

ansi = [${1}, ${2}, ${3}, ${4}, ${5}, ${6}, ${7}, ${8}]
brights = [${9}, ${10}, ${11}, ${12}, ${13}, ${14}, ${15}, ${16}]

compose_cursor = ${ModeMsg.fg}

quick_select_label_bg = {Color = ${Normal.bg}}
quick_select_label_fg = {Color = ${Label.fg}}
quick_select_match_bg = {Color = ${Normal.bg}}
quick_select_match_fg = {Color = ${Comment.fg}}

[colors.tab_bar]
background = ${TabLineFill.bg}

[colors.tab_bar.active_tab]
bg_color = ${TabLineSel.bg}
fg_color = ${TabLineSel.fg}
italic = ${TabLineSel.italic}
intensity = ${TabLineSel.blend | TabLineSel.bold}
strikethrough = ${TabLineSel.strikethrough}
underline = ${TabLineSel.underdouble | TabLineSel.underline | TabLineSel.undercurl | TabLineSel.underdashed | TabLineSel.underdotted}

[colors.tab_bar.inactive_tab]
bg_color = ${TabLine.bg}
fg_color = ${TabLine.fg}
italic = ${TabLine.italic}
intensity = ${TabLine.blend | TabLine.bold}
strikethrough = ${TabLine.strikethrough}
underline = ${TabLine.underdouble | TabLine.underline | TabLine.undercurl | TabLine.underdashed | TabLine.underdotted}

[colors.tab_bar.inactive_tab_hover]
bg_color = ${TabLine.bg}
fg_color = ${TabLine.fg}
italic = ${TabLineSel.italic}
intensity = ${TabLineSel.blend | TabLineSel.bold}
strikethrough = ${TabLineSel.strikethrough}
underline = ${TabLineSel.underdouble | TabLineSel.underline | TabLineSel.undercurl | TabLineSel.underdashed | TabLineSel.underdotted}

[colors.tab_bar.new_tab]
bg_color = ${Normal.bg}
fg_color = ${Normal.fg}

[colors.tab_bar.new_tab_hover]
bg_color = ${Normal.fg}
fg_color = ${Normal.bg}
]]

	--- @type highlite.Fmt.string.opts
	local FMT_OPTS =
	{
		default =
		{
			blend = '"Normal"',
			bold = '"Normal"',
			italic = false,
			strikethrough = false,
			undercurl = '"None"',
			underdashed = '"None"',
			underdotted = '"None"',
			underdouble = '"None"',
			underline = '"None"',
		},

		map = function(attribute, value)
			if value then
				if attribute == 'bold' then
					value = '"Bold"'
				elseif attribute == 'blend' and value > 49 then
					value = '"Half"'
				elseif attribute == 'underdouble' then
					value = '"Bold"'
				elseif attribute == 'underline' or
					attribute == 'undercurl' or
					attribute == 'underdashed' or
					attribute == 'underdotted'
				then
					value = '"Single"'
				end
			end

			return value
		end,
	}

	--- Create a wezterm theme out of the `palette`
	--- @type highlite.export.format
	function Export.wezterm(colorscheme, opts, dir)
		if opts == nil then opts = {} end

		-- checked for backwards compatability
		if dir == nil then
			dir = opts.dir or vim.loop.os_getenv(vim.loop.os_uname().sysname == 'Windows' and
				'WEZTERM_EXECUTABLE_DIR' or
				'WEZTERM_CONFIG_DIR'
			) .. '/colors'
		end

		dir = vim.fs.normalize(dir)
		local filename = opts.filename or colorscheme
		local previous_colorscheme = vim.api.nvim_get_var 'colors_name'

		Util.switch_colorscheme(colorscheme)

		Fs.write(
			dir .. '/' .. filename .. '.toml',
			'[metadata]\nname = "' .. filename .. Fmt.string(FMT, FMT_OPTS),
			opts
		)

		Util.switch_colorscheme(previous_colorscheme)
	end
end

return Export
