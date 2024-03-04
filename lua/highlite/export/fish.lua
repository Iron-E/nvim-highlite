local Fmt = require 'highlite.fmt' --- @type highlite.Fmt
local Nvim = require 'highlite.nvim' --- @type highlite.Nvim

local FMT = [[
fish_color_normal ${Normal.fg | Normal.sp}${Normal.bold}${Normal.italic}${Normal.underline}
fish_color_command ${@function.fg | function.sp | Function.fg | Function.sp}${@function.bold | Function.bold}${@function.italic | Function.italic}${@function.underline | Function.underline}
fish_color_keyword ${@keyword.fg | keyword.sp | Keyword.fg | Keyword.sp}${@keyword.bold | Keyword.bold}${@keyword.italic | Keyword.italic}${@keyword.underline | Keyword.underline}
fish_color_quote ${@string.fg | string.sp | String.fg | String.sp}${@string.bold | String.bold}${@string.italic | String.italic}${@string.underline | String.underline}
fish_color_redirection ${@operator.fg | operator.sp | Operator.fg | Operator.sp}${@operator.bold | Operator.bold}${@operator.italic | Operator.italic}${@operator.underline | Operator.underline}
fish_color_end ${@punctuation.delimiter.fg | delimiter.sp | Delimiter.fg | Delimiter.sp}${@punctuation.delimiter.bold | Delimiter.bold}${@punctuation.delimiter.italic | Delimiter.italic}${@punctuation.delimiter.underline | Delimiter.underline}
fish_color_error ${@error.fg | error.sp | Error.fg | Error.sp}${@error.bg | Error.bg}${@error.bold | Error.bold}${@error.italic | Error.italic}${@error.underline | Error.underline}
fish_color_param ${@variable.parameter.fg | parameter.sp | Identifier.fg | Identifier.sp}${@variable.parameter.bold | Identifier.bold}${@variable.parameter.italic | Identifier.italic}${@variable.parameter.underline | Identifier.underline}
fish_color_valid_path ${@string.special.path.fg | path.sp | Directory.fg | Directory.sp}${@string.special.path.bold | Directory.bold}${@string.special.path.italic | Directory.italic}${@string.special.path.underline | Directory.underline}
fish_color_option ${@variable.parameter.fg | parameter.sp | Identifier.fg | Identifier.sp}${@variable.parameter.bold | Identifier.bold}${@variable.parameter.italic | Identifier.italic}${@variable.parameter.underline | Identifier.underline}
fish_color_comment ${@comment.fg | comment.sp | Comment.fg | Comment.sp}${@comment.bold | Comment.bold}${@comment.italic | Comment.italic}${@comment.underline | Comment.underline}
fish_color_selection ${Visual.fg | Visual.sp}${Visual.bg}${Visual.bold}${Visual.italic}${Visual.underline}
fish_color_operator ${@character.special.fg | special.sp | Special.fg | Special.sp}${@character.special.bold | Special.bold}${@character.special.italic | Special.italic}${@character.special.underline | Special.underline}
fish_color_escape ${@string.escape.fg | escape.sp | SpecialChar.fg | SpecialChar.sp}${@string.escape.bold | SpecialChar.bold}${@string.escape.italic | SpecialChar.italic}${@string.escape.underline | SpecialChar.underline}
fish_color_autosuggestion ${LspInlayHint.fg | LspInlayHint.sp | Ignore.fg | Ignore.sp}${LspInlayHint.bold | Ignore.bold}${LspInlayHint.italic | Ignore.italic}${LspInlayHint.underline | Ignore.underline}
fish_color_cwd ${Directory.fg | Directory.sp}${Directory.bold}${Directory.italic}${Directory.underline}
fish_color_cwd_root ${Directory.fg | Directory.sp}${Directory.bold}${Directory.italic}${Directory.underline}
fish_color_status ${DiagnosticSignError.fg | DiagnosticSignError.sp | @keyword.exception.fg | exception.sp | ErrorMsg.fg | ErrorMsg.sp}${DiagnosticSignError.bold | @keyword.exception.bold | ErrorMsg.bold}${DiagnosticSignError.italic | @keyword.exception.italic | ErrorMsg.italic}${DiagnosticSignError.underline | @keyword.exception.underline | ErrorMsg.underline}
fish_color_cancel ${@string.escape.fg | escape.sp | SpecialChar.fg | SpecialChar.sp}${@string.escape.bold | SpecialChar.bold}${@string.escape.italic | SpecialChar.italic}${@string.escape.underline | SpecialChar.underline}${Normal.bg}${Normal.bold}${Normal.italic}${Normal.underline}
fish_color_search_match ${PmenuSel.fg | PmenuSel.sp}${PmenuSel.bg}${PmenuSel.bold}${PmenuSel.italic}${PmenuSel.underline} | Search.fg | Search.sp}${IncSearch.bg | Search.bg}${IncSearch.bold | Search.bold}${IncSearch.italic | Search.italic}${IncSearch.underline | Search.underline} | Search.fg | Search.sp}${IncSearch.bg | Search.bg}${IncSearch.bold | Search.bold}${IncSearch.italic | Search.italic}${IncSearch.underline | Search.underline}
fish_color_history_current ${PmenuSel.fg | PmenuSel.sp}${PmenuSel.bg}${PmenuSel.bold}${PmenuSel.italic}${PmenuSel.underline} | Search.fg | Search.sp}${IncSearch.bg | Search.bg}${IncSearch.bold | Search.bold}${IncSearch.italic | Search.italic}${IncSearch.underline | Search.underline}

fish_pager_color_prefix ${Search.fg | Search.sp} ${Search.bg} ${Search.bold} ${Search.italic} ${Search.underline}
fish_pager_color_description ${@comment.documentation.fg} ${@comment.documentation.bg} ${@comment.documentation.bold} ${@comment.documentation.italic} ${@comment.documentation.underline}
]]

--- @type highlite.Fmt.string.opts
local FMT_OPTS =
{
	convert_int_attributes = 'hex_literal',
	default = setmetatable({}, { __index = function() return '' end }),

	map =
	{
		bg = function(v) return ' --background ' .. tostring(v):sub(3) end,
		fg = function(v) return tostring(v):sub(3) end,
		bold = function() return ' --bold' end,
		italic = function() return ' --italic' end,
		reverse = function() return ' --reverse' end,
		underline = function() return ' --underline' end,
	},
}

FMT_OPTS.map.sp = FMT_OPTS.map.fg
FMT_OPTS.map.undercurl = FMT_OPTS.map.underline
FMT_OPTS.map.underdashed = FMT_OPTS.map.underline
FMT_OPTS.map.underdotted = FMT_OPTS.map.underline
FMT_OPTS.map.underdouble = FMT_OPTS.map.underline

--- Create a wezterm theme out of the `palette`
--- @type highlite.export.format.module
local function export(colorscheme, opts, dir)
	if opts == nil then opts = {} end

	-- checked for backwards compatability
	if dir == nil then
		dir = opts.dir or (vim.fn.system({'fish', '-c', 'echo $__fish_config_dir/themes'}):sub(1, -2))
	end

	dir = vim.fs.normalize(dir)
	local filename = opts.filename or colorscheme

	local content --- @type string
	Nvim.with_colorscheme(colorscheme, function()
		local output = Fmt.string(FMT, FMT_OPTS)
		while output:find('  ') do
			output = output:gsub('  ', ' ')
		end

		content = '# Colorscheme: ' .. colorscheme
			.. '\n# Generated by nvim-highlite'
			.. '\n\n' .. output
	end)

	return dir .. '/' .. filename .. '.theme', content, opts
end

return export
