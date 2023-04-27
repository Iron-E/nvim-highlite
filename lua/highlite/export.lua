local Fmt = require 'highlite.fmt' --- @type highlite.Fmt
local Fs = require 'highlite.fs' --- @type highlite.Fs
local Util = require 'highlite.utils' --- @type highlite.Utils

--- @class highlite.Export
local Export = {}

--- @alias highlite.export.format async fun(colorscheme: string, write_opts?: highlite.Fs.write.opts, dir?: string)

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
	function Export.wezterm(colorscheme, write_opts, dir)
		local previous_colorscheme = vim.g.colors_name

		Util.switch_colorscheme(colorscheme)

		if dir == nil then
			dir = vim.loop.os_getenv(
				vim.loop.os_uname().sysname == 'Windows' and
					'WEZTERM_EXECUTABLE_DIR' or
					'WEZTERM_CONFIG_DIR'
			) .. '/colors'
		end

		local toml = '[metadata]\nname = "' .. colorscheme .. Fmt.string(FMT, FMT_OPTS)

		Fs.write(vim.fs.normalize(dir) .. '/' .. colorscheme .. '.toml', toml, write_opts)
		Util.switch_colorscheme(previous_colorscheme)
	end
end

return Export
