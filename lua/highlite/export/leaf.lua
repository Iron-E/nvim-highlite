local Fmt = require("highlite.fmt") --- @type highlite.Fmt
local Nvim = require("highlite.nvim") --- @type highlite.Nvim
local Util = require("highlite.export.util") --- @type highlite.export.Util

local FMT = [[
[ui]
content_bg = ${Normal.bg}
scrollbar_hover = ${PmenuThumb.bg}
status_bg = ${StatusLine.bg}
status_brand_bg = ${ModeMsg.bg | StatusLine.bg}
status_brand_fg = ${ModeMsg.fg}
status_error_bg = ${ErrorMsg.bg | StatusLine.bg}
status_error_fg = ${ErrorMsg.fg}
status_filename_bg = ${Directory.bg | StatusLine.bg}
status_filename_fg = ${Directory.fg}
status_percent_fg = ${@number.fg | Number.fg}
status_reloaded_bg = ${OkMsg.bg | StatusLine.bg}
status_reloaded_fg = ${OkMsg.fg}
status_search_bg = ${StatusLine.bg}
status_search_fg = ${Normal.fg}
status_separator = ${@punctuation.separator.fg | Delimiter.fg}
status_shortcut_fg = ${SpecialKey.fg}
status_success_bg = ${OkMsg.bg | StatusLine.bg}
status_success_fg = ${OkMsg.fg}
status_warning_fg = ${WarningMsg.fg}
status_watch_bg = ${@diff.delta.bg | StatusLine.bg}
status_watch_fg = ${@diff.delta.fg}
toc_accent = ${CursorLineNr.fg}
toc_active_bg = ${PmenuSel.bg}
toc_bg = ${Pmenu.bg | NormalFloat.bg}
toc_border = ${PmenuBorder.fg | FloatBorder.fg}
toc_header_fg = ${@markup.heading.fg | NormalFloat.fg}
toc_inactive_bg = ${Pmenu.bg | NormalFloat.bg}
toc_index_inactive = ${@number.fg | Number.fg}
toc_primary_active = ${@markup.heading.fg | NormalFloat.fg}
toc_primary_inactive = ${@markup.heading.fg | NormalFloat.fg}
toc_secondary_inactive = ${@markup.heading.fg | NormalFloat.fg}
toc_secondary_text_active = ${@markup.heading.fg | NormalFloat.fg}
toc_secondary_text_inactive = ${@markup.heading.fg | NormalFloat.fg}

[markdown]
alert_caution = ${DiagnosticSignError.fg}
alert_important = ${DiagnosticSignOk.fg}
alert_note = ${DiagnosticSignInfo.fg}
alert_tip = ${DiagnosticSignHint.fg}
alert_warning = ${DiagnosticSignWarn.fg}
blockquote_marker = ${@punctuation.special.fg}
blockquote_text = ${@markup.quote.fg}
code_frame = ${@markup.raw.block.fg}
code_gutter = ${@markup.raw.block.fg}
code_label = ${@label.fg | Label.fg}
heading_1 = ${@markup.heading.1.fg}
heading_2 = ${@markup.heading.2.fg}
heading_3 = ${@markup.heading.3.fg}
heading_4 = ${@markup.heading.4.fg}
heading_other = ${@markup.heading.5.fg}
heading_underline = ${@markup.heading.sp | MsgSeparator.fg}
inline_code_bg = ${@markup.raw.bg}
inline_code_fg = ${@markup.raw.fg}
latex_block_fg = ${@markup.math.fg}
latex_inline_bg = ${@markup.math.bg}
latex_inline_fg = ${@markup.math.fg}
link_hover = ${@markup.link.fg}
link_icon = ${@markup.link.label.fg}
link_text = ${@markup.link.label.fg}
list_level_1 = ${@markup.list.fg}
list_level_2 = ${@markup.list.fg}
list_level_3 = ${@markup.list.fg}
mark_bg = ${Normal.fg}
mark_fg = ${Normal.bg}
mermaid_arrow = ${WinSeparator.fg}
mermaid_block_fg = ${Normal.fg}
mermaid_keyword = ${@keyword.fg | Keyword.fg}
mermaid_label = ${@label.fg | Label.fg}
ordered_list = ${@markup.list.fg}
rule = ${@conceal.fg | Conceal.fg}
search_highlight_bg = ${CursorLine.bg}
search_match_bg = ${Visual.bg}
strong_text = ${@markup.strong.fg | Bold.fg | Normal.fg}
table_border = ${WinSeparator.fg}
table_cell = ${Normal.fg}
table_header = ${@markup.heading.fg | Normal.fg}
table_separator = ${WinSeparator.fg}
task_checked = ${@markup.list.checked.fg}
task_unchecked = ${@markup.list.checked.bg}
text = ${Normal.fg}
]]

--- @type highlite.Fmt.string.opts
local FMT_OPTS = {
	default = {
		fg = "null",
		bg = "null",
		sp = "null",
	},
}

--- Create a wezterm theme out of the `palette`
--- @type highlite.export.format.module
local function export(colorscheme, opts, dir)
	if opts == nil then
		opts = {}
	end

	if opts.args == nil then
		opts.args = {}
	end

	local syntax = opts.args.syntax or "base16-ocean.dark"

	-- checked for backwards compatability
	dir = Util.get_normalized_dir("leaf", dir or opts.dir, function()
		local config_home
		if vim.loop.os_uname().sysname == "Windows" then
			config_home = vim.fn.expand("%APPDATA%")
		else
			config_home = vim.loop.os_getenv("XDG_CONFIG_HOME") or (vim.loop.os_homedir() .. "/.config")
		end

		local leaf_themes_config = config_home .. "/leaf"

		return leaf_themes_config .. "/themes"
	end)

	local filename = opts.filename or colorscheme

	local content --- @type string
	Nvim.with_colorscheme(colorscheme, function()
		content = 'syntax = "' .. syntax .. '"\n' .. Fmt.string(FMT, FMT_OPTS):gsub("[%w_]+%s+=%s+null\n", "")
	end)

	return dir .. "/" .. filename .. ".toml", content, opts
end

return export
