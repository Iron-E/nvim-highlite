local Fmt = require 'highlite.fmt' --- @type highlite.Fmt
local Nvim = require 'highlite.nvim' --- @type highlite.Nvim
local Util = require 'highlite.export.util' --- @type highlite.export.Util

local FMT = [[
		text_unselected {
			base ${Normal.sp | Normal.fg}
			background ${Normal.bg}
			emphasis_0 ${@markup.heading.1.fg | @comment.error.fg}
			emphasis_1 ${@markup.heading.2.fg | @comment.warning.fg}
			emphasis_2 ${@markup.heading.3.fg | @comment.todo.fg}
			emphasis_3 ${@markup.heading.4.fg | @comment.note.fg}
		}

		text_selected {
			base ${Visual.sp | Visual.fg | Normal.sp | Normal.fg}
			background ${Visual.bg}
			emphasis_0 ${@markup.heading.1.fg | @comment.error.fg}
			emphasis_1 ${@markup.heading.2.fg | @comment.warning.fg}
			emphasis_2 ${@markup.heading.3.fg | @comment.todo.fg}
			emphasis_3 ${@markup.heading.4.fg | @comment.note.fg}
		}

		ribbon_selected {
			base ${TabLineSel.bg}
			background ${TabLineSel.sp}
			emphasis_0 ${@markup.heading.1.fg | @comment.error.fg}
			emphasis_1 ${@markup.heading.2.fg | @comment.warning.fg}
			emphasis_2 ${@markup.heading.3.fg | @comment.todo.fg}
			emphasis_3 ${@markup.heading.4.fg | @comment.note.fg}
		}

		ribbon_unselected {
			base ${TabLine.sp | TabLine.fg}
			background ${TabLine.bg}
			emphasis_0 ${@markup.heading.1.fg | @comment.error.fg}
			emphasis_1 ${@markup.heading.2.fg | @comment.warning.fg}
			emphasis_2 ${@markup.heading.3.fg | @comment.todo.fg}
			emphasis_3 ${@markup.heading.4.fg | @comment.note.fg}
		}

		table_title {
			base ${@markup.heading.fg | Title.fg | @markup.strong.fg | Normal.fg}
			background ${@markup.heading.fg | Title.fg | @markup.strong.fg | Normal.fg}
			emphasis_0 ${@markup.heading.1.fg | @comment.error.fg}
			emphasis_1 ${@markup.heading.2.fg | @comment.warning.fg}
			emphasis_2 ${@markup.heading.3.fg | @comment.todo.fg}
			emphasis_3 ${@markup.heading.4.fg | @comment.note.fg}
		}

		table_cell_selected {
			base ${Visual.sp | Visual.fg | Normal.sp | Normal.fg}
			background ${Visual.bg}
			emphasis_0 ${@markup.heading.1.fg | @comment.error.fg}
			emphasis_1 ${@markup.heading.2.fg | @comment.warning.fg}
			emphasis_2 ${@markup.heading.3.fg | @comment.todo.fg}
			emphasis_3 ${@markup.heading.4.fg | @comment.note.fg}
		}

		table_cell_unselected {
			base ${Normal.sp | Normal.fg}
			background ${Normal.bg}
			emphasis_0 ${@markup.heading.1.fg | @comment.error.fg}
			emphasis_1 ${@markup.heading.2.fg | @comment.warning.fg}
			emphasis_2 ${@markup.heading.3.fg | @comment.todo.fg}
			emphasis_3 ${@markup.heading.4.fg | @comment.note.fg}
		}

		list_selected {
			base ${Visual.sp | Visual.fg | Normal.sp | Normal.fg}
			background ${Visual.bg}
			emphasis_0 ${@markup.heading.1.fg | @comment.error.fg}
			emphasis_1 ${@markup.heading.2.fg | @comment.warning.fg}
			emphasis_2 ${@markup.heading.3.fg | @comment.todo.fg}
			emphasis_3 ${@markup.heading.4.fg | @comment.note.fg}
		}

		list_unselected {
			base ${Normal.sp | Normal.fg}
			background ${Normal.bg}
			emphasis_0 ${@markup.heading.1.fg | @comment.error.fg}
			emphasis_1 ${@markup.heading.2.fg | @comment.warning.fg}
			emphasis_2 ${@markup.heading.3.fg | @comment.todo.fg}
			emphasis_3 ${@markup.heading.4.fg | @comment.note.fg}
		}

		frame_selected {
			base 172 151 57
			background 0
			emphasis_0 ${@markup.heading.1.fg | @comment.error.fg}
			emphasis_1 ${@markup.heading.2.fg | @comment.warning.fg}
			emphasis_2 ${@markup.heading.3.fg | @comment.todo.fg}
			emphasis_3 ${@markup.heading.4.fg | @comment.note.fg}
		}

		frame_highlight {
			base 199 107 41
			background 0
			emphasis_0 ${@markup.heading.1.fg | @comment.error.fg}
			emphasis_1 ${@markup.heading.2.fg | @comment.warning.fg}
			emphasis_2 ${@markup.heading.3.fg | @comment.todo.fg}
			emphasis_3 ${@markup.heading.4.fg | @comment.note.fg}
		}

		exit_code_success {
			base ${DiagnosticSignOk.sp | DiagnosticSignOk.fg}
			background ${DiagnosticSignOk.bg}
			emphasis_0 ${@markup.heading.1.fg | @comment.error.fg}
			emphasis_1 ${@markup.heading.2.fg | @comment.warning.fg}
			emphasis_2 ${@markup.heading.3.fg | @comment.todo.fg}
			emphasis_3 ${@markup.heading.4.fg | @comment.note.fg}
		}

		exit_code_error {
			base ${@error.sp | @error.fg | Error.sp | Error.fg}
			background ${@error.bg | Error.bg}
			emphasis_0 ${@markup.heading.1.fg | @comment.error.fg}
			emphasis_1 ${@markup.heading.2.fg | @comment.warning.fg}
			emphasis_2 ${@markup.heading.3.fg | @comment.todo.fg}
			emphasis_3 ${@markup.heading.4.fg | @comment.note.fg}
		}

		multiplayer_user_colors {
			player_1 156 99 122
			player_2 61 143 209
			player_3 0
			player_4 192 139 48
			player_5 34 162 201
			player_6 0
			player_7 201 73 34
			player_8 0
			player_9 0
			player_10 0
		}
]]

--- @type highlite.Fmt.string.opts
local FMT_OPTS =
{
}

--- Create a wezterm theme out of the `palette`
--- @type highlite.export.format.module
local function export(colorscheme, opts, dir)
	if opts == nil then opts = {} end

	-- checked for backwards compatability
	dir = Util.get_normalized_dir('zellij', dir or opts.dir, function()
		local zellij_setup = vim.fn.system({'zellij', 'setup', '--check'})
		local config_file = zellij_setup:match('%[CONFIG DIR%]: "([^"]+)"')
		return config_file .. '/themes'
	end)

	local filename = opts.filename or colorscheme

	local content --- @type string
	Nvim.with_colorscheme(colorscheme, function()
		content =
			'// https://github.com/Iron-E/nvim-highlite\n'
			.. 'themes {\n'
			.. '\t' .. colorscheme .. ' {\n'
			.. Fmt.string(FMT, FMT_OPTS)
			.. '\t}\n'
			.. '}\n'
	end)

	return dir .. '/' .. filename .. '.kdl', content, opts
end

return export
