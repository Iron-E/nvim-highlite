local Fmt = require 'highlite.fmt' --- @type highlite.Fmt
local Fs = require 'highlite.fs' --- @type highlite.Fs
local Nvim = require 'highlite.nvim' --- @type highlite.Nvim

--- Skip plugins that don't depend on a colorscheme
--- @param group string
--- @return boolean filter_it
local function include_hl_group_for_nvim_export(group)
	return not (
		group:find '^colorizer_' or
		group:find '^DevIcon' or
		group:find '^Stl_?[1-9a-f]*'
	)
end

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

vim.api.nvim_set_var('colors_name', '%s')
]]

	--- @return string
	local function fmt_groups()
		local s = ''

		local groups = vim.api.nvim_get_hl(0, {})
		local keys = vim.tbl_keys(groups)
		table.sort(keys)

		for _, group in ipairs(keys) do
			local definition = groups[group]
			if include_hl_group_for_nvim_export(group) then
				s = s .. "\n\thl(0, '" .. group .. "', " .. vim.inspect(definition, {indent = '', newline = ' '}) .. ')'
			end
		end

		return s
	end

	--- @return string
	local function fmt_terminal()
		return '\n\n\tg.terminal_color_0 = ' .. vim.inspect(vim.g.terminal_color_0) ..
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
		local by_bg = {}
		local filename = opts.filename or colorscheme

		Nvim.with_colorscheme(colorscheme, function()
			Nvim.with_both_bgs(function(bg) by_bg[bg] = {groups = fmt_groups(), terminal = fmt_terminal()} end)
		end)

		Fs.write(
			dir .. '/' .. filename .. '.lua',
			FMT:format(by_bg.dark.groups, by_bg.dark.terminal, by_bg.light.groups, by_bg.light.terminal, filename),
			opts
		)
	end
end

do
	local FMT = [[
highlight clear
if &background == 'dark' %s%s
else%s%s
endif

let g:colors_name = '%s'
]]

	--- Disables default values in a `:highlight` command.
	local NONE = 'NONE'

	--- Used to generate `gui=` and `cterm=` fields of a `:highlight` command.
	--- @param definition table
	--- @param attribute string
	local function attr(definition, attribute)
		return definition[attribute] and attribute .. ',' or ''
	end

	--- Convert the `base_10` integer to a hex string, or return `NONE`
	--- @param base_10? integer
	--- @return string
	local function hex(base_10)
		return base_10 and '#' .. bit.tohex(base_10, 6) or NONE
	end

	--- @return string
	local function fmt_groups()
		local s = ''

		local groups = vim.api.nvim_get_hl(0, {})
		local keys = vim.tbl_keys(groups)
		table.sort(keys)

		for _, group in ipairs(keys) do
			local definition = groups[group]
			if include_hl_group_for_nvim_export(group) then
				if definition.cterm == nil then definition.cterm = {} end
				if definition.link then
					s = s .. '\n\thi link ' .. group .. ' ' .. definition.link
				else
					local cterm =
						attr(definition.cterm, 'bold') ..
						attr(definition.cterm, 'italic') ..
						attr(definition.cterm, 'nocombine') ..
						attr(definition.cterm, 'reverse') ..
						attr(definition.cterm, 'standout') ..
						attr(definition.cterm, 'strikethrough') ..
						attr(definition.cterm, 'strikethrough') ..
						attr(definition.cterm, 'undercurl') ..
						attr(definition.cterm, 'underdashed') ..
						attr(definition.cterm, 'underdotted') ..
						attr(definition.cterm, 'underdouble') ..
						attr(definition.cterm, 'underline')

					if #cterm < 1 then
						cterm = NONE
					end

					local gui =
						attr(definition, 'bold') ..
						attr(definition, 'italic') ..
						attr(definition, 'nocombine') ..
						attr(definition, 'reverse') ..
						attr(definition, 'standout') ..
						attr(definition, 'strikethrough') ..
						attr(definition, 'strikethrough') ..
						attr(definition, 'undercurl') ..
						attr(definition, 'underdashed') ..
						attr(definition, 'underdotted') ..
						attr(definition, 'underdouble') ..
						attr(definition, 'underline')

					if #gui < 1 then
						gui = NONE
					end

					s = s .. '\n\thi ' .. group ..
						' blend=' .. (definition.blend or NONE) ..
						' cterm=' .. cterm ..
						' ctermbg=' .. (definition.ctermbg or NONE) ..
						' ctermfg=' .. (definition.ctermfg or NONE) ..
						' gui=' .. gui ..
						' guibg=' .. hex(definition.bg) ..
						' guifg=' .. hex(definition.fg) ..
						' guisp=' .. hex(definition.sp)
				end
			end
		end

		return s
	end

	--- Convert a `nil` value to one that is parseable in VimScript
	--- @param color? highlite.color
	--- @return string
	local function nil_to_null(color)
		return color == nil and 'v:null' or vim.inspect(color)
	end

	--- @return string
	local function fmt_terminal()
		return '\n\n\tlet g:terminal_color_0 = ' .. nil_to_null(vim.g.terminal_color_0) ..
			'\n\tlet g:terminal_color_1 = ' .. nil_to_null(vim.g.terminal_color_1) ..
			'\n\tlet g:terminal_color_2 = ' .. nil_to_null(vim.g.terminal_color_2) ..
			'\n\tlet g:terminal_color_3 = ' .. nil_to_null(vim.g.terminal_color_3) ..
			'\n\tlet g:terminal_color_4 = ' .. nil_to_null(vim.g.terminal_color_4) ..
			'\n\tlet g:terminal_color_5 = ' .. nil_to_null(vim.g.terminal_color_5) ..
			'\n\tlet g:terminal_color_6 = ' .. nil_to_null(vim.g.terminal_color_6) ..
			'\n\tlet g:terminal_color_7 = ' .. nil_to_null(vim.g.terminal_color_7) ..
			'\n\tlet g:terminal_color_8 = ' .. nil_to_null(vim.g.terminal_color_8) ..
			'\n\tlet g:terminal_color_9 = ' .. nil_to_null(vim.g.terminal_color_9) ..
			'\n\tlet g:terminal_color_10 = ' .. nil_to_null(vim.g.terminal_color_10) ..
			'\n\tlet g:terminal_color_11 = ' .. nil_to_null(vim.g.terminal_color_11) ..
			'\n\tlet g:terminal_color_12 = ' .. nil_to_null(vim.g.terminal_color_12) ..
			'\n\tlet g:terminal_color_13 = ' .. nil_to_null(vim.g.terminal_color_13) ..
			'\n\tlet g:terminal_color_14 = ' .. nil_to_null(vim.g.terminal_color_14) ..
			'\n\tlet g:terminal_color_15 = ' .. nil_to_null(vim.g.terminal_color_15)
	end

	--- NOTE: this function strips out leading dots from colorscheme names, e.g. `.foo` → `foo`.
	---       You can use this to create a bootstrap custom colorscheme in `colors/.custom.lua` and it will get written
	---       to `colors/custom.lua`.
	--- @type highlite.export.format
	function Export.vim(colorscheme, opts, dir)
		if opts == nil then opts = {} end

		-- checked for backwards compatability
		if dir == nil then
			dir = opts.dir or vim.fn.stdpath('config') .. '/colors/'
		end

		dir = vim.fs.normalize(dir)
		local by_bg = {}
		local filename = opts.filename or colorscheme

		Nvim.with_colorscheme(colorscheme, function()
			Nvim.with_both_bgs(function(bg) by_bg[bg] = {groups = fmt_groups(), terminal = fmt_terminal()} end)
		end)

		Fs.write(
			dir .. '/' .. filename .. '.vim',
			FMT:format(by_bg.dark.groups, by_bg.dark.terminal, by_bg.light.groups, by_bg.light.terminal, filename),
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

		Nvim.with_colorscheme(colorscheme, function()
			Fs.write(
				dir .. '/' .. filename .. '.toml',
				'[metadata]\nname = "' .. filename .. Fmt.string(FMT, FMT_OPTS),
				opts
			)
		end)
	end
end

return Export
