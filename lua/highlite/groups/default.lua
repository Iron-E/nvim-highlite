local Groups = require 'highlite.groups' --- @type highlite.Groups
local Options = require 'highlite.groups.options' --- @type highlite.groups.Options

--- resolve highlight groups being defined by links.
--- @package
--- @param groups highlite.groups the current table being indexed.
--- @param name string the key to resolve the value for.
--- @return highlite.group.new # the value at `tbl[key]`, when highlight links and embedded functions have been accounted for.
local function resolve(groups, name) -- {{{
	local original_group = rawget(groups, name) or {}

	if type(original_group) == 'string'  then
		return resolve(groups, original_group)
	elseif original_group.link then
		return resolve(groups, original_group.link)
	end

	return original_group
end -- }}}

--- Used to allow calling a table to resolve its contents.
--- @package
local RESOLVE_METATABLE = {__call = resolve}

--- Generate the default highlight groups using the `palette`.
--- @type highlite.groups.from_palette
local function from_palette(palette, opts)
	local all_nvim_plugins, any_nvim_plugins,
		all_syntax, any_syntax,
		all_vim_plugins, any_vim_plugins = Options.parse_from_palette(opts)

	local line_nr = {fg = palette.text_contrast_bg_low}
	local status_line = {fg = palette.string, bg = palette.bg_contrast_high}

	local tabline = {fg = palette.text, bg = palette.bg_contrast_high}
	local tabline_fill = {fg = palette.bg, bg = palette.bg}
	local tabline_sel = {fg = palette.text, bg = palette.bg_contrast_low, sp = palette.buffer_current, underline = true}

	local buffer_alternate = Groups.extend({sp = palette.buffer_alternate, underline = true}, tabline)
	local buffer_visible = Groups.extend({sp = palette.buffer_active, underline = true}, tabline)

	--- @type highlite.groups.FromPalette
	local groups = -- {{{
	{
		--[[ Plaintext ]]

		-- Basic styles
		Bold = {bold = true},
		Italic = {italic = true},
		Normal = {fg = palette.text, bg = palette.bg},
		Title = 'Bold',
		Underlined = {fg = palette.uri, underline = true},
		Whitespace = 'NonText',
		H1 = {fg = palette.error, bold = true},
		H2 = {fg = palette.warning, bold = true},
		H3 = {fg = palette.diff_change, bold = true},
		H4 = {fg = palette.string, bold = true},
		H5 = {fg = palette.type, bold = true},
		H6 = {fg = palette.fold, bold = true},

		-- "Non"-text
		Conceal = 'Ignore',
		EndOfBuffer = 'NonText',
		Ignore = {fg = palette.text_contrast_bg_low},
		NonText = {fg = palette.bg_contrast_high},

		-- Literals
		Constant = {fg = palette.constant},
		String = {fg = palette.string},
		Character = {fg = palette.character},
		Number = {fg = palette.number},
		Boolean = {fg = palette.boolean},
		Float = {fg = palette.float},

		-- Syntax
		Comment = {fg = palette.text_contrast_bg_low, italic = true},
		Conditional = {fg = palette.conditional, italic = true},
		Debug = 'WarningMsg',
		Delimiter = {fg = palette.punctuation},
		Exception = {fg = palette.throw, bold = true},
		Function = {fg = palette.func},
		Identifier = {fg = palette.identifier},
		Keyword = {fg = palette.keyword},
		Label = {fg = palette.label, bold = true},
		Noise = 'Delimiter',
		Operator = {fg = palette.operator, bold = true},
		Repeat = {fg = palette.loop, italic = true},
		Statement = {fg = palette.statement},
		StorageClass = {fg = palette.storage, bold = true},
		Structure = {fg = palette.structure, bold = true},
		Type = {fg = palette.type},
		Typedef = {fg = palette.type, italic = true},

		-- Pre-processor
		Define = {fg = palette.define, nocombine = true},
		Include = {fg = palette.include, nocombine = true},
		Macro = {fg = palette.macro, italic = true},
		PreCondit = {fg = palette.preproc_conditional, italic = true},
		PreProc = {fg = palette.preproc},

		-- Special
		Special = {fg = palette.special, bold = true},
		SpecialChar = '@string.escape',
		SpecialComment = {fg = palette.comment_documentation, bold = true, nocombine = true},
		SpecialKey = '@character.special',

		--[[ Editor UI ]]

		-- Status Line
		StatusLine = status_line,
		StatusLineNC = {fg = palette.text_contrast_bg_low, bg = status_line.bg},
		StatusLineTerm = 'StatusLine',
		StatusLineTermNC = 'StatusLineNC',

		-- Tabline
		TabLine = tabline,
		TabLineFill = tabline_fill,
		TabLineSel = tabline_sel,

		-- Line Highlighting
		CursorLine = {bg = palette.bg_contrast_low},
		CursorLineNr = Groups.extend({fg = palette.number}, line_nr),
		LineNr = line_nr,
		QuickFixLine = {bg = status_line.bg},
		Visual = {bg = palette.select},
		VisualNOS = 'Visual',

		-- Popups
		FloatBorder = {fg = palette.text_contrast_bg_low},
		--(FloatTitle defined below)
		NormalFloat = 'Pmenu',
		Pmenu = {fg = palette.text, bg = palette.bg_contrast_low},
		PmenuSbar = {bg = palette.bg_contrast_high},
		PmenuSel = {bg = palette.select},
		PmenuThumb = {bg = palette.text_contrast_bg_high},
		WildMenu = 'PmenuSel',

		-- Folds
		FoldColumn = {bg = palette.bg_contrast_high, bold = true},
		Folded = {fg = palette.bg, bg = palette.fold, italic = true},

		-- Diffs
		DiffAdd = {fg = palette.bg, bg = palette.string},
		diffAdded = 'DiffAdd',
		DiffChange = {},
		DiffDelete = {fg = palette.bg, bg = palette.error},
		DiffText = {fg = palette.bg, bg = palette.diff_change},
		diffRemoved = 'DiffDelete',

		-- Jumping
		Tag = 'Underlined',
		--(MatchParen defined below)

		-- Searching
		IncSearch = {bg = palette.search, fg = palette.bg, nocombine = true},
		Search = {sp = palette.search, underline = true},

		-- Spelling
		SpellBad = 'DiagnosticUnderlineError',
		SpellCap = 'DiagnosticUnderlineHint',
		SpellLocal = 'DiagnosticUnderlineWarn',
		SpellRare = 'DiagnosticUnderlineOk',

		-- Conditional Column Highlighting
		ColorColumn = {bg = palette.bg_contrast_high},
		SignColumn = {},

		-- Messages
		Error = {fg = palette.bg, bg = palette.syntax_error, bold = true},
		ErrorMsg = {fg = palette.error, bold = true},
		ModeMsg = {fg = palette.message},
		MoreMsg = 'ModeMsg',
		Question = {fg = palette.message, underline = true},
		Todo = {fg = palette.bg, bg = palette.todo, bold = true},
		WarningMsg = {fg = palette.warning, bold = true},

		-- Diagnostics
		debugBreakpoint = 'ErrorMsg',
		debugPC = 'ColorColumn',

		DiagnosticDeprecated = {strikethrough = true},

		DiagnosticError = 'Error',
		DiagnosticFloatingError = 'ErrorMsg',
		DiagnosticSignError = 'DiagnosticFloatingError',
		DiagnosticUnderlineError = {sp = palette.error, undercurl = true},

		DiagnosticHint = {fg = palette.bg, bg = palette.hint, bold = true},
		DiagnosticFloatingHint = {fg = palette.hint},
		DiagnosticSignHint = 'DiagnosticFloatingHint',
		DiagnosticUnderlineHint = {sp = palette.hint, undercurl = true},

		DiagnosticInfo = {fg = palette.bg, bg = palette.info, bold = true},
		DiagnosticFloatingInfo = {fg = palette.info},
		DiagnosticSignInfo = 'DiagnosticFloatingInfo',
		DiagnosticUnderlineInfo = {sp = palette.info, undercurl = true},

		DiagnosticOk = {fg = palette.bg, bg = palette.ok, bold = true},
		DiagnosticFloatingOk = {fg = palette.ok},
		DiagnosticSignOk = 'DiagnosticFloatingOk',
		DiagnosticUnderlineOk = {sp = palette.ok, undercurl = true},

		DiagnosticWarn = {fg = palette.bg, bg = palette.warning, bold = true},
		DiagnosticFloatingWarn = 'WarningMsg',
		DiagnosticSignWarn = 'DiagnosticFloatingWarn',
		DiagnosticUnderlineWarn = {sp = palette.warning, undercurl = true},

		DiagnosticUnnecessary = {sp = palette.text_contrast_bg_low, underdotted = true},

		-- Cursor
		Cursor = {bg = palette.text_contrast_bg_high, fg = palette.bg},
		CursorIM = 'Cursor',
		CursorColumn = {bg = palette.bg_contrast_low},

		-- Misc
		Directory = '@namespace',
		MsgSeparator = {bg = palette.text_contrast_bg_high},
		WinSeparator = {fg = palette.text_contrast_bg_high},

		--[[ Syntax (LSP / TreeSitter) ]]

		-- LSP
		['@lsp.mod.annotation'] = {fg = palette.annotation},
		['@lsp.mod.constant'] = '@constant',
		['@lsp.mod.interpolation'] = '@string.special',
		['@lsp.mod.readonly'] = '@lsp.mod.constant',
		['@lsp.mod.static'] = '@lsp.mod.constant',
		['@lsp.type.boolean'] = '@boolean',
		['@lsp.type.character'] = '@character',
		['@lsp.type.class'] = {fg = palette.class, bold = true},
		['@lsp.type.decorator'] = {fg = palette.decorator},
		['@lsp.type.enum'] = {fg = palette.enum, bold = true},
		['@lsp.type.enumMember'] = {fg = palette.field_enum},
		['@lsp.type.float'] = '@float',
		['@lsp.type.interface'] = {fg = palette.interface},
		['@lsp.type.keyword'] = '@keyword',
		['@lsp.type.macro'] = '@macro',
		['@lsp.type.method'] = '@method',
		['@lsp.type.namespace'] = '@namespace',
		['@lsp.type.number'] = '@number',
		['@lsp.type.operator'] = '@operator',
		['@lsp.type.parameter'] = '@parameter',
		['@lsp.type.property'] = '@property',
		['@lsp.type.string'] = '@string',
		['@lsp.type.struct'] = '@structure',
		['@lsp.type.type'] = '@type',
		['@lsp.type.typeParameter'] = {fg = palette.type_parameter, italic = true},
		['@lsp.type.variable'] = '@variable',
		['@lsp.typemod.function.defaultLibrary'] = '@function.builtin',
		['@lsp.typemod.string.constant'] = '@lsp.typemod.string.static',
		['@lsp.typemod.string.readonly'] = '@lsp.typemod.string.static',
		['@lsp.typemod.string.static'] = '@lsp.type.string',
		['@lsp.typemod.type.defaultLibrary'] = '@type.builtin',
		['@lsp.typemod.type.readonly'] = '@lsp.type.type',
		['@lsp.typemod.variable.defaultLibrary'] = '@variable.builtin',

		-- Treesitter
		['@attribute'] = {fg = palette.attribute},
		['@character.special'] = {fg = palette.character_special, bold = true},
		['@comment.documentation'] = 'SpecialComment',
		['@conceal'] = 'Conceal',
		['@constant.builtin'] = {fg = palette.constant_builtin},
		['@constructor'] = {fg = palette.constructor},
		['@error'] = 'Error',
		['@event'] = {fg = palette.event},
		['@field'] = {fg = palette.field},
		['@function.builtin'] = {fg = palette.func_builtin},
		['@keyword.coroutine'] = {fg = palette.keyword_coroutine},
		['@keyword.function'] = {fg = palette.keyword_function},
		['@keyword.operator'] = {fg = palette.keyword_operator},
		['@keyword.return'] = {fg = palette.keyword_return},
		['@method'] = {fg = palette.method},
		['@namespace'] = {fg = palette.namespace, bold = true},
		['@parameter'] = {fg = palette.parameter, italic = true},
		['@preproc.conditional'] = 'PreCondit',
		['@property'] = {fg = palette.property},
		['@punctuation.bracket'] = {fg = palette.punctuation_bracket},
		['@punctuation.delimiter'] = {fg = palette.punctuation_delimiter},
		['@punctuation.special'] = {fg = palette.punctuation_special},
		['@string.documentation'] = '@comment.documentation',
		['@string.escape'] = {fg = palette.string_escape, italic = true},
		['@string.regex'] = {fg = palette.string_regex},
		['@string.special'] = {fg = palette.string_special},
		['@structure'] = 'Structure',
		['@tag'] = {fg = palette.tag, bold = true},
		['@tag.attribute'] = {fg = palette.tag_attribute},
		['@tag.delimiter'] = {fg = palette.tag_delimiter},
		['@text'] = {fg = palette.text},
		['@text.danger'] = 'DiagnosticError',
		['@text.diff.add'] = 'DiffAdd',
		['@text.diff.delete'] = 'DiffDelete',
		['@text.emphasis'] = 'Italic',
		['@text.literal'] = {fg = palette.text_literal},
		['@text.note'] = 'DiagnosticInfo',
		['@text.quote'] = '@comment',
		['@text.reference'] = {fg = palette.text_reference},
		['@text.strike'] = {strikethrough = true},
		['@text.strong'] = 'Bold',
		['@text.todo'] = 'Todo',
		['@text.underline'] = {underline = true},
		['@text.warning'] = 'DiagnosticWarn',
		['@type.builtin'] = {fg = palette.type_builtin},
		['@variable'] = {fg = palette.variable},
		['@variable.builtin'] = {fg = palette.variable_builtin, italic = true},

		-- Dart
		['@lsp.type.string.dart'] = {},

		-- Go
		['@lsp.type.number.go'] = {},
		['@lsp.type.operator.go'] = {},
		['@lsp.type.string.go'] = {},

		-- Lua
		['@lsp.typemod.function.declaration.lua'] = '@lsp.type.function',
		['@lsp.typemod.function.global.lua'] = '@lsp.type.function',
		['@lsp.typemod.variable.defaultLibrary.lua'] = '@lsp.type.class.lua',
		['@lsp.typemod.variable.definition.lua'] = '@lsp.typemod.variable.defaultLibrary',

		-- Rust
		['@lsp.mod.callable.rust'] = '@lsp.type.function',
		['@lsp.type.builtinType.rust'] = '@lsp.type.type',
		['@lsp.type.character.rust'] = {},
		['@lsp.type.decorator.rust'] = '@preproc',
		['@lsp.type.derive.rust'] = '@macro',
		['@lsp.type.enumMember.rust'] = {},
		['@lsp.type.macro.rust'] = {},
		['@lsp.type.operator.rust'] = {},
		['@lsp.type.selfKeyword.rust'] = '@keyword.rust',
		['@lsp.type.selfTypeKeyword.rust'] = '@lsp.type.typeAlias.rust',
		['@lsp.type.string.rust'] = {},
		['@lsp.type.typeAlias.rust'] = '@type.definition',
		['@lsp.typemod.character.injected.rust'] = '@lsp.type.character',
		['@lsp.typemod.deriveHelper.attribute.rust'] = '@lsp.type.decorator.rust',
		['@lsp.typemod.keyword.injected.rust'] = '@keyword.rust',
		['@lsp.typemod.macro.injected.rust'] = '@macro',
		['@lsp.typemod.operator.injected.rust'] = '@operator',
		['@lsp.typemod.string.injected.rust'] = '@lsp.type.string',
	} -- }}}

	setmetatable(groups, RESOLVE_METATABLE)

	--- @diagnostic disable:param-type-mismatch these are not nil
	groups.FloatTitle = Groups.extend({bold = true}, groups 'NormalFloat')
	groups.MatchParen = Groups.extend({bold = true}, groups 'Tag')
	--- @diagnostic enable:param-type-mismatch

	if any_nvim_plugins then
		local nvim_plugins = type(opts.plugins) == 'table' and opts.plugins.nvim or {}

		if all_nvim_plugins or nvim_plugins.barbar ~= false then
			groups.BufferAlternate = buffer_alternate
			groups.BufferAlternateADDED = Groups.extend({fg = palette.diff_add}, buffer_alternate)
			groups.BufferAlternateCHANGED = Groups.extend({fg = palette.diff_change}, buffer_alternate)
			groups.BufferAlternateDELETED = Groups.extend({fg = palette.diff_delete}, buffer_alternate)
			groups.BufferAlternateERROR = Groups.extend({fg = palette.diff_delete}, buffer_alternate)
			groups.BufferAlternateHINT = Groups.extend({fg = palette.hint}, buffer_alternate)
			groups.BufferAlternateIndex = Groups.extend({fg = palette.number}, buffer_alternate)
			groups.BufferAlternateINFO = Groups.extend({fg = palette.info}, buffer_alternate)
			groups.BufferAlternateMod = Groups.extend({fg = palette.diff_change, bold = true}, buffer_alternate)
			groups.BufferAlternateSign = Groups.extend({fg = tabline_fill.fg}, buffer_alternate)
			groups.BufferAlternateTarget = Groups.extend({fg = palette.buffer_alternate, bold = true}, buffer_alternate)
			groups.BufferAlternateWARN = Groups.extend({fg = palette.warning}, buffer_alternate)

			groups.BufferCurrent = 'TabLineSel'
			groups.BufferCurrentADDED = Groups.extend({fg = palette.diff_add}, tabline_sel)
			groups.BufferCurrentCHANGED = Groups.extend({fg = palette.diff_change}, tabline_sel)
			groups.BufferCurrentDELETED = Groups.extend({fg = palette.diff_delete}, tabline_sel)
			groups.BufferCurrentERROR = Groups.extend({fg = palette.error}, tabline_sel)
			groups.BufferCurrentHINT = Groups.extend({fg = palette.hint}, tabline_sel)
			groups.BufferCurrentIndex = Groups.extend({fg = palette.number}, tabline_sel)
			groups.BufferCurrentINFO = Groups.extend({fg = palette.info}, tabline_sel)
			groups.BufferCurrentMod = Groups.extend({fg = palette.diff_change, bold = true}, tabline_sel)
			groups.BufferCurrentSign = Groups.extend({fg = tabline_fill.fg}, tabline_sel)
			groups.BufferCurrentTarget = Groups.extend({fg = palette.buffer_current, bold = true}, tabline_sel)
			groups.BufferCurrentWARN = Groups.extend({fg = palette.warning}, tabline_sel)

			groups.BufferInactive = 'TabLine'
			groups.BufferInactiveADDED = Groups.extend({fg = palette.diff_add}, tabline)
			groups.BufferInactiveCHANGED = Groups.extend({fg = palette.diff_change}, tabline)
			groups.BufferInactiveDELETED = Groups.extend({fg = palette.diff_delete}, tabline)
			groups.BufferInactiveERROR = Groups.extend({fg = palette.error}, tabline)
			groups.BufferInactiveHINT = Groups.extend({fg = palette.hint}, tabline)
			groups.BufferInactiveIndex = Groups.extend({fg = palette.number}, tabline)
			groups.BufferInactiveINFO = Groups.extend({fg = palette.info}, tabline)
			groups.BufferInactiveMod = Groups.extend({fg = palette.diff_change, bold = true}, tabline)
			groups.BufferInactiveSign = Groups.extend({fg = tabline_fill.fg}, tabline)
			groups.BufferInactiveTarget = Groups.extend({bold = true}, tabline)
			groups.BufferInactiveWARN = Groups.extend({fg = palette.warning}, tabline)

			groups.BufferTabpages = {bold = true}
			groups.BufferTabpageFill = 'TabLineFill'

			groups.BufferVisible = buffer_visible
			groups.BufferVisibleADDED = Groups.extend({fg = palette.diff_add}, buffer_visible)
			groups.BufferVisibleCHANGED = Groups.extend({fg = palette.diff_change}, buffer_visible)
			groups.BufferVisibleDELETED = Groups.extend({fg = palette.diff_delete}, buffer_visible)
			groups.BufferVisibleERROR = Groups.extend({fg = palette.error}, buffer_visible)
			groups.BufferVisibleHINT = Groups.extend({fg = palette.hint}, buffer_visible)
			groups.BufferVisibleIndex = Groups.extend({fg = palette.number}, buffer_visible)
			groups.BufferVisibleINFO = Groups.extend({fg = palette.info}, buffer_visible)
			groups.BufferVisibleMod = Groups.extend({fg = palette.diff_change, bold = true}, buffer_visible)
			groups.BufferVisibleSign = Groups.extend({fg = tabline_fill.fg}, buffer_visible)
			groups.BufferVisibleTarget = Groups.extend({fg = palette.buffer_active, bold = true}, buffer_visible)
			groups.BufferVisibleWARN = Groups.extend({fg = palette.warning}, buffer_visible)
		end

		if all_nvim_plugins or nvim_plugins.cmp ~= false then
			groups.CmpItemAbbr = 'Ignore'
			groups.CmpItemAbbrMatch = 'Underlined'
			groups.CmpItemAbbrMatchFuzzy = {fg = palette.text, nocombine = true, underdotted = true}
			groups.CmpItemKindClass = 'CmpItemKindStruct'
			groups.CmpItemKindsp = 'Label'
			groups.CmpItemKindConstant = 'Constant'
			groups.CmpItemKindConstructor = 'CmpItemKindMethod'
			groups.CmpItemKind = '@type'
			groups.CmpItemKindEnum = '@lsp.type.enum'
			groups.CmpItemKindEnumMember = '@lsp.type.enumMember'
			groups.CmpItemKindEvent = '@event'
			groups.CmpItemKindField = '@field'
			groups.CmpItemKindFile = 'Directory'
			groups.CmpItemKindFolder = 'CmpItemKindFile'
			groups.CmpItemKindFunction = '@function'
			groups.CmpItemKindInterface = '@interface'
			groups.CmpItemKindKeyword = '@keyword'
			groups.CmpItemKindMethod = '@method'
			groups.CmpItemKindModule = '@namespace'
			groups.CmpItemKindOperator = '@operator'
			groups.CmpItemKindProperty = '@property'
			groups.CmpItemKindReference = '@storageclass'
			groups.CmpItemKindSnippet = 'Special'
			groups.CmpItemKindStruct = '@structure'
			groups.CmpItemKindText = '@string'
			groups.CmpItemKindTypeParameter = '@lsp.type.typeParameter'
			groups.CmpItemKindUnit = 'Special'
			groups.CmpItemKindValue = '@constant'
			groups.CmpItemKindVariable = '@variable'
		end

		if all_nvim_plugins or nvim_plugins.gitsigns ~= false then
			groups.GitSignsAdd = {fg = palette.diff_add}
			groups.GitSignsChange = {fg = palette.diff_change}
			groups.GitSignsDelete = {fg = palette.diff_delete}
		end

		if all_nvim_plugins or nvim_plugins.indent_blankline ~= false then
			groups.IndentBlanklineSpaceChar = 'IndentBlanklineChar'
			groups.IndentBlanklineChar = Groups.extend({nocombine = true}, groups 'Whitespace')
		end

		if all_nvim_plugins or nvim_plugins.lazy ~= false then
			groups.LazyButton = 'TabLine'
			groups.LazyButtonActive = 'TabLineSel'
			groups.LazyCommit = '@number.lazy'
			groups.LazyCommitIssue = 'LazyUrl'
			groups.LazyCommitType = '@type.lazy'
			groups.LazyDir = 'Directory'
			groups.LazyH1 = 'H1'
			groups.LazyH2 = 'H2'
			groups.LazyProp = '@field.lazy'
			groups.LazyReasonEvent = '@repeat.lazy'
			groups.LazyReasonFt = '@conditional.lazy'
			groups.LazyReasonImport = '@function.lazy'
			groups.LazyReasonKeys = '@string.lazy'
			groups.LazyReasonPlugin = '@label.lazy'
			groups.LazyReasonSource = '@include.lazy'
			groups.LazyReasonStart = '@constant.lazy'
			groups.LazySpecial = 'Special'
			groups.LazyTaskOutput = 'Statement'
			groups.LazyUrl = '@text.uri.lazy'
		end

		if all_nvim_plugins or nvim_plugins.lspsaga ~= false then
			groups.DefinitionCount = 'Number'
			groups.DefinitionIcon = 'Special'
			groups.ReferencesCount = 'Number'
			groups.ReferencesIcon = 'DefinitionIcon'
			groups.TargetFileName = 'Directory'
			groups.TargetWord = '@text.title'
		end

		if all_nvim_plugins or nvim_plugins.mini ~= false then
			groups.MiniJump = 'MiniJump2dSpot'
			groups.MiniSurround = {reverse = true}
		end

		if all_nvim_plugins or nvim_plugins.nvim_tree ~= false then
			-- TODO: make this not depend on GitSigns
			groups.NvimTreeGitDeleted = 'GitSignsDelete'
			groups.NvimTreeGitDirty = {fg = palette.warning}
			groups.NvimTreeGitIgnored = 'Ignore'
			groups.NvimTreeGitMerge = 'NvimTreeGitRenamed'
			groups.NvimTreeGitNew = 'GitSignsAdd'
			groups.NvimTreeGitRenamed = 'GitSignsChange'
			groups.NvimTreeGitStaged = {fg = palette.type}
		end

		if all_nvim_plugins or nvim_plugins.packer ~= false then
			groups.packerFail = 'DiagnosticFloatingError'
			groups.packerHash = 'Number'
			groups.packerPackageNotLoaded = 'Ignore'
			groups.packerStatusFail = 'Statement'
			groups.packerStatusSuccess = 'packerStatusFail'
			groups.packerSuccess = 'DiagnosticFloatingOk'
		end

		if all_nvim_plugins or nvim_plugins.symbols_outline ~= false then
			groups.FocusedSymbol = {}
			groups.SymbolsOutlineConnector = 'Delimiter'
		end

		if all_nvim_plugins or nvim_plugins.todo_comments ~= false then
			groups.TodoFgFIX = {fg = palette.error}
			groups.TodoFgHACK = {fg = palette.diff_change}
			groups.TodoFgNOTE = {fg = palette.info}
			groups.TodoFgPERF = {fg = palette.ok}
			groups.TodoFgTEST = {fg = palette.hint}
			groups.TodoFgTODO = {fg = palette.todo}
			groups.TodoFgWARN = {fg = palette.warning}

			groups.TodoBgFIX = {fg = palette.bg, bg = palette.error, bold = true, italic = true, nocombine = true}
			groups.TodoBgHACK = {fg = palette.bg, bg = palette.diff_change, bold = true, italic = true, nocombine = true}
			groups.TodoBgNOTE = {fg = palette.bg, bg = palette.info, bold = true, italic = true, nocombine = true}
			groups.TodoBgPERF = {fg = palette.bg, bg = palette.ok, bold = true, italic = true, nocombine = true}
			groups.TodoBgTEST = {fg = palette.bg, bg = palette.hint, bold = true, italic = true, nocombine = true}
			groups.TodoBgTODO = {fg = palette.bg, bg = palette.todo, bold = true, italic = true, nocombine = true}
			groups.TodoBgWARN = {fg = palette.bg, bg = palette.warning, bold = true, italic = true, nocombine = true}

			groups.TodoSignFIX = 'TodoFgFIX'
			groups.TodoSignHACK = 'TodoFgHACK'
			groups.TodoSignNOTE = 'TodoFgNOTE'
			groups.TodoSignPERF = 'TodoFgPERF'
			groups.TodoSignTEST = 'TodoFgTEST'
			groups.TodoSignTODO = 'TodoFgTODO'
			groups.TodoSignWARN = 'TodoFgWARN'
		end

		if all_nvim_plugins or nvim_plugins.trouble ~= false then
			groups.TroubleCount = {fg = palette.number, sp = palette.text_contrast_bg_high, underline = true}
		end
	end

	if any_vim_plugins then
		local vim_plugins = type(opts.plugins) == 'table' and opts.plugins.vim or {}

		if all_vim_plugins or vim_plugins.ale ~= false then
			groups.ALEErrorSign = 'DiagnosticSignError'
			groups.ALEWarningSign = 'DiagnosticSignWarn'
		end

		if all_vim_plugins or vim_plugins.coc ~= false then
			groups.CocErrorHighlight = 'DiagnosticUnderlineError'
			groups.CocErrorSign = 'DiagnosticSignError'
			groups.CocHintHighlight = 'DiagnosticUnderlineHint'
			groups.CocHintSign = 'DiagnosticSignHint'
			groups.CocInfoHighlight = 'DiagnosticUnderlineInfo'
			groups.CocInfoSign = 'DiagnosticSignInfo'
			groups.CocWarningHighlight = 'DiagnosticUnderlineWarn'
			groups.CocWarningSign = 'DiagnosticSignWarn'
		end

		if all_vim_plugins or vim_plugins.fern ~= false then
			groups.FernBranchText = 'Directory'
		end

		if all_vim_plugins or vim_plugins.nerdtree ~= false then
			groups.NERDTreeCWD = 'Label'
			groups.NERDTreeUp = 'Operator'
			groups.NERDTreeDir = 'Directory'
			groups.NERDTreeDirSlash = 'Delimiter'
			groups.NERDTreeOpenable = 'NERDTreeDir'
			groups.NERDTreeClosable = 'NERDTreeOpenable'
			groups.NERDTreeExecFile = 'Function'
			groups.NERDTreeLinkTarget = 'Tag'
		end

		if all_vim_plugins or vim_plugins.vim_easymotion ~= false then
			groups.EasyMotion = {reverse = true}
		end

		if all_vim_plugins or vim_plugins.vim_gitgutter ~= false then
			groups.GitGutterAdd = {fg = palette.diff_add}
			groups.GitGutterChange = {fg = palette.diff_change}
			groups.GitGutterDelete = {fg = palette.diff_delete}
			groups.GitGutterChangeDelete = 'GitGutterChange'
		end

		if all_vim_plugins or vim_plugins.vim_indent_guides ~= false then
			groups.IndentGuidesOdd = {bg = palette.bg_contrast_high}
			groups.IndentGuidesEven = {bg = palette.text_contrast_bg_low}
		end

		if all_vim_plugins or vim_plugins.vim_jumpmotion ~= false then
			groups.JumpMotion = {reverse = true}
		end

		if all_vim_plugins or vim_plugins.vim_sandwich ~= false then
			groups.OperatorSandwichChange = 'DiffText'
		end

		if all_vim_plugins or vim_plugins.vim_signify ~= false then
			groups.SignifySignAdd = {fg = palette.diff_add}
			groups.SignifySignChange = {fg = palette.diff_change}
			groups.SignifySignDelete = {fg = palette.diff_delete}
			groups.SignifySignChangeDelete = 'SignifySignChange'
		end
	end

	if any_syntax then
		local syntax = opts.syntax

		if all_syntax or syntax.coq ~= false then
			groups.coqConstructor = 'Constant'
			groups.coqDefBinderType = 'coqDefType'
			groups.coqDefContents1 = 'coqConstructor'
			groups.coqDefType = 'Typedef'
			groups.coqIndBinderTerm = 'coqDefBinderType'
			groups.coqIndConstructor = 'Delimiter'
			groups.coqIndTerm = 'Type'
			groups.coqKwd = 'Keyword'
			groups.coqKwdParen = 'Function'
			groups.coqProofDelim = 'coqVernacCmd'
			groups.coqProofDot = 'coqTermPunctuation'
			groups.coqProofPunctuation = 'coqTermPunctuation'
			groups.coqRequire = 'Include'
			groups.coqTactic = 'Operator'
			groups.coqTermPunctuation = 'Delimiter'
			groups.coqVernacCmd = 'Statement'
			groups.coqVernacPunctuation = 'coqTermPunctuation'
		end

		if all_syntax or syntax.cpp ~= false then
			groups.cppSTLexception = '@exception.cpp'
			groups.cppSTLnamespace = '@namespace.cpp'
		end

		if all_syntax or syntax.cs ~= false then
			groups.csAccessModifier = '@keyword.cs'
			groups.csAccessor = 'csLogicSymbols'
			groups.csBraces = '@punctuation.bracket.cs'
			groups.csClass = 'csAccessModifier'
			groups.csClassType = '@lsp.type.class.cs'
			groups.csContextualStatement = '@conditional.cs'
			groups.csEndColon = '@punctuation.delimiter.cs'
			groups.csGeneric = '@lsp.type.typeParameter.cs'
			groups.csInterpolation = '@string.special.cs'
			groups.csInterpolationDelimiter = '@punctuation.special.cs'
			groups.csLogicSymbols = '@operator.cs'
			groups.csModifier = '@storageclass.cs'
			groups.csNew = 'csLogicSymbols'
			groups.csNewType = '@type.cs'
			groups.csParens = 'csBraces'
			groups.csPreCondit = '@preproc.conditional.cs'
			groups.csQuote = 'csEndColon'
			groups.csRepeat = '@repeat.cs'
			groups.csStorage = 'csAccessModifier'
			groups.csUnspecifiedStatement = 'csModifier'
			groups.csXmlTag = 'xmlTagName'
		end

		if all_syntax or syntax.css ~= false then
			groups.cssAtRule = '@preproc.conditional.css'
			groups.cssAttr = '@keyword.css'
			groups.cssAttrComma = '@punctuation.delimiter.css'
			groups.cssAttributeSelector = '@field.html'
			groups.cssAttrRegion = '@keyword.css'
			groups.cssBraces = 'Delimiter'
			groups.cssClassName = '@lsp.type.class.css'
			groups.cssClassNameDot = 'cssAttrComma'
			groups.cssColor = '@string.css'
			groups.cssFlexibleBoxAttr = 'cssAttr'
			groups.cssFunctionComma = 'cssAttrComma'
			groups.cssIdentifier = '@label.css'
			groups.cssNoise = '@punctuation.css'
			groups.cssProp = '@field.css'
			groups.cssPseudoClass = '@type.builtin'
			groups.cssPseudoClassId = '@keyword.css'
			groups.cssSelectorOp = '@operator.css'
			groups.cssSelectorOp2 = 'cssSelectorOp'
			groups.cssTagName = '@tag.html'
			groups.cssUIProp = 'cssProp'
			groups.cssUnitDecorators = '@type.css'
			groups.cssVendor = '@preproc.css'
		end

		if all_syntax or syntax.dart ~= false then
			groups.dartClassDecl = 'dartStatement'
			groups.dartSpecialChar = '@string.escape.dart'
			groups.dartInterpolation = '@string.special'
			groups.dartLibrary = 'dartStatement'
			groups.dartStatement = '@keyword.dart'
			groups.dartUri = '@namespace.dart'
		end

		if all_syntax or syntax.dosini ~= false then
			groups.dosiniHeader = '@structure.dosini'
			groups.dosiniLabel = '@field.dosini'
		end

		if all_syntax or syntax.dot ~= false then
			groups.dotKeyChar = '@character.dot'
			groups.dotType = '@type.dot'
		end

		if all_syntax or syntax.git ~= false then
			groups.gitcommitHeader = '@comment.documentation.gitcommit'
			groups.gitcommitDiscardedFile = 'gitcommitSelectedFile'
			groups.gitcommitOverFlow = '@error.gitcommit'
			groups.gitcommitSelectedFile = 'Directory'
			groups.gitcommitSummary = '@text.title.gitcommitSummary'
			groups.gitcommitUntrackedFile = 'gitcommitSelectedFile'

			groups.gitconfigAssignment = 'String'
			groups.gitconfigEscape = '@string.escape'
			groups.gitconfigNone = 'Operator'
			groups.gitconfigSection = '@structure.gitconfig'
			groups.gitconfigVariable = '@field.gitconfig'

			groups.gitrebaseBreak = '@keyword.gitrebase'
			groups.gitrebaseCommit = '@number.gitrebase'
			groups.gitrebaseDrop = '@exception.gitrebase'
			groups.gitrebaseEdit = '@define.gitrebase'
			groups.gitrebaseExec = '@preproc.gitrebase'
			groups.gitrebaseFixup = 'gitrebaseSquash'
			groups.gitrebaseMerge = '@preproc.gitrebase'
			groups.gitrebasePick = '@include.gitrebase'
			groups.gitrebaseReset = 'gitrebaseLabel'
			groups.gitrebaseReword = 'gitrebasePick'
			groups.gitrebaseSquash = '@macro.gitrebase'
			groups.gitrebaseSummary = '@text.title.gitrebaseSummary'
		end

		if all_syntax or syntax.go ~= false then
			groups.goBlock = '@punctuation.bracket.go'
			groups.goBoolean = '@boolean.go'
			groups.goBuiltins = '@function.builtin.go'
			groups.goEscapeC = '@string.escape.go'
			groups.goField = '@field.go'
			groups.goFloat = '@float.go'
			groups.goFormatSpecifier = '@string.regex.go'
			groups.goFunction = '@function.go'
			groups.goFunctionCall = 'goFunction'
			groups.goFunctionReturn = {}
			groups.goImport = '@include.go'
			groups.goImportString = '@namespace.go'
			groups.goMethodCall = 'goFunctionCall'
			groups.goPackage = 'goStatement'
			groups.goParamType = 'goReceiverType'
			groups.goPointerOperator = '@storageclass.go'
			groups.goPredefinedIdentifiers = '@constant.go'
			groups.goReceiver = 'goBlock'
			groups.goReceiverType = 'goTypeName'
			groups.goSimpleParams = 'goBlock'
			groups.goStatement = '@keyword.go'
			groups.goType = '@type.go'
			groups.goTypeConstructor = 'goFunction'
			groups.goTypeName = 'goType'
			groups.goVarAssign = '@variable.go'
			groups.goVarDefs = 'goVarAssign'
		end

		if all_syntax or syntax.help ~= false then
			groups.helpCommand = '@text.literal.help'
			groups.helpHeader = '@label.help'
			groups.helpHeadline = '@text.title.help'
			groups.helpHyperTextJump = '@text.uri.help'
			groups.helpHyperTextEntry = 'helpHyperTextJump'
			groups.helpExample = 'helpCommand'
			groups.helpNote = 'DiagnosticHint'
			groups.helpOption = '@keyword.help'
			groups.helpSectionDelim = '@punctuation.delimiter.help'
		end

		if all_syntax or syntax.html ~= false then
			groups.htmlArg = '@tag.attribute'
			groups.htmlSpecialChar = '@character.special.html'
			groups.htmlBold = 'Bold'
			groups.htmlEndTag = 'htmlTag'
			groups.htmlH1 = 'H1'
			groups.htmlH2 = 'H2'
			groups.htmlH3 = 'H3'
			groups.htmlH4 = 'H4'
			groups.htmlH5 = 'H5'
			groups.htmlH6 = 'H6'
			groups.htmlItalic = 'Italic'
			groups.htmlSpecialTagName = '@keyword.html'
			groups.htmlTag = '@tag.delimiter.html'
			groups.htmlTagN = '@tag'
			groups.htmlTagName = 'htmlSpecialTagName'
			groups.htmlTitle = '@text.title.html'
		end

		if all_syntax or syntax.i3config ~= false then
			groups.i3ConfigAction = '@function.builtin.i3config'
			groups.i3ConfigAssign = 'i3ConfigVariable'
			groups.i3ConfigAssignKeyword = '@keyword.i3config'
			groups.i3ConfigBind = '@text'
			groups.i3ConfigBindArgument = '@parameter.sh'
			groups.i3ConfigBindKeyword = '@keyword.i3config'
			groups.i3ConfigBlockKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigBorderKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigBorderStyleKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigClientColorKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigCommandKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigDelayUrgencyKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigDrawingMarksKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigEdgeKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigExec = 'Statement'
			groups.i3ConfigExecKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigFloating = 'i3ConfigBindKeyword'
			groups.i3ConfigFocusFollowsMouseKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigFocusOnActivationKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigFocusWrappingKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigFontContent = 'i3ConfigString'
			groups.i3ConfigFontKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigFontSeparator = '@punctuation.delimiter.i3config'
			groups.i3ConfigFontSize = 'i3ConfigNumber'
			groups.i3ConfigForceXineramaKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigGapStyleKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigInitialize = 'i3ConfigString'
			groups.i3ConfigInitializeKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigInterprocessKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigLayoutKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigMouseWarpingKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigNoFocusKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigNumber = '@number.i3config'
			groups.i3ConfigOrientationKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigPopupOnFullscreenKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigResourceKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigSmartBorderKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigSmartGapKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigString = '@string.i3config'
			groups.i3ConfigTitleAlignKeyword = 'i3ConfigBindKeyword'
			groups.i3ConfigUnit = '@type.i3config'
			groups.i3ConfigUnitOr = '@operator.i3config'
			groups.i3ConfigVariable = '@define.i3config'
			groups.i3ConfigVariableAndModifier = '@character.i3config'
			groups.i3ConfigVariableModifier = '@operator.i3config'
			groups.i3ConfigWindowCommandSpecial = '@punctuation.bracket.i3config'
			groups.i3ConfigWorkspaceKeyword = 'i3ConfigBindKeyword'
		end

		if all_syntax or syntax.java ~= false then
			groups.javaClassDecl = '@lsp.type.class.java'
		end

		if all_syntax or syntax.javascript ~= false then
			groups.jsExceptions = '@structure.javascript'
			groups.jsFuncBlock = '@function.javascript'
			groups.jsGlobalNodeObjects = '@include.javascript'
			groups.jsGlobalObjects = '@type.builtin.javascript'
			groups.jsObjectKey = '@type.javascript'
			groups.jsOf = '@repeat.javascript'
			groups.jsReturn = '@keyword.return.javascript'
			groups.jsSpecial = '@string.escape'
			groups.jsStorageClass = '@keyword.javascript'
			groups.jsThis = '@keyword.javascript'
			groups.jsVariableDef = '@variable.javascript'
		end

		if all_syntax or syntax.json ~= false then
			groups.jsonBraces = '@punctuation.bracket.json'
			groups.jsonEscape = '@string.escape.json'
			groups.jsonKeyword = '@field.json'
			groups.jsonKeywordMatch = '@operator.json'
			groups.jsonNull = '@constant.builtin.json'
			groups.jsonQuote = '@punctuation.bracket.json'
			groups.jsonString = '@string.json'
		end

		if all_syntax or syntax.lua ~= false then
			groups.luaBraces = '@structure.lua'
			groups.luaBrackets = 'luaParens'
			groups.luaBuiltin = '@keyword.lua'
			groups.luaComma = '@punctuation.delimiter.lua'
			groups.luaDocTag = '@keyword.lua'
			groups.luaEllipsis = '@variable.builtin.lua'
			groups.luaFuncArgName = '@parameter.lua'
			groups.luaFuncCall = '@function.call.lua'
			groups.luaFuncId = 'luaComma'
			groups.luaFuncKeyword = '@type.lua'
			groups.luaFuncName = '@function.lua'
			groups.luaFuncParens = 'luaParens'
			groups.luaFuncTable = '@structure.lua'
			groups.luaGotoLabel = '@label.lua'
			groups.luaIn = '@repeat.lua'
			groups.luaLocal = 'luaStatement'
			groups.luaNoise = '@punctuation.lua'
			groups.luaParens = '@punctuation.bracket.lua'
			groups.luaSpecialTable = '@lsp.typemod.variable.defaultLibrary.lua'
			groups.luaSpecialValue = '@lsp.typemod.function.defaultLibrary.lua'
			groups.luaStatement = '@keyword.lua'
			groups.luaStringLongTag = Groups.extend({italic = true}, groups '@punctuation.bracket')
		end

		if all_syntax or syntax.make ~= false then
			groups.makeCommands = 'Statement'
			groups.makeSpecTarget = '@type.make'
		end

		if all_syntax or syntax.man ~= false then
			groups.manHeader = 'H1'
			groups.manOptionDesc = '@parameter.sh'
			groups.manReference = '@text.uri'
			groups.manSectionHeading = 'H2'
			groups.manSubHeading = 'H3'
			groups.manUnderline = '@text.literal'
		end

		if all_syntax or syntax.markdown ~= false then
			groups.markdownCode = 'mkdCode'
			groups.markdownCodeDelimiter = 'mkdCodeDelimiter'
			groups.markdownEscape = '@string.escape.markdown'
			groups.markdownH1 = 'H1'
			groups.markdownH2 = 'H2'
			groups.markdownH3 = 'H3'
			groups.markdownH4 = 'H4'
			groups.markdownH5 = 'H5'
			groups.markdownH6 = 'H6'
			groups.markdownLinkDelimiter = 'mkdDelimiter'
			groups.markdownLinkText = 'mkdLink'
			groups.markdownLinkTextDelimiter = 'markdownLinkDelimiter'
			groups.markdownListMarker = 'markdownOrderedListMarker'
			groups.markdownOrderedListMarker = 'mkdListItem'
			groups.markdownSpecialChar = '@string.special.markdown'
			groups.markdownUrl = 'mkdLink'

			groups.mkdBold = '@conceal.markdown'
			groups.mkdBoldItalic = 'mkdBold'
			groups.mkdCode = '@text.literal.markdown'
			groups.mkdCodeDelimiter = 'mkdBold'
			groups.mkdCodeEnd = 'mkdCodeStart'
			groups.mkdCodeStart = 'mkdCodeDelimiter'
			groups.mkdDelimiter = '@punctuation.bracket.markdown'
			groups.mkdHeading = '@punctuation.delimiter.markdown'
			groups.mkdItalic = 'mkdBold'
			groups.mkdLineBreak = 'NonText'
			groups.mkdLink = '@text.uri.markdown'
			groups.mkdListItem = '@character.special.markdown'
			groups.mkdRule = {fg = palette.text_contrast_bg_low, sp = palette.text_contrast_bg_high, underline = true}
			groups.mkdURL = 'mkdLink'
		end

		if all_syntax or syntax.python ~= false then
			groups.pythonBrackets = '@punctuation.bracket.python'
			groups.pythonBuiltinFunc = '@function.builtin.python'
			groups.pythonBuiltinObj = '@lsp.type.class.python'
			groups.pythonBuiltinType = '@type.builtin.python'
			groups.pythonClass = '@lsp.type.class.python'
			groups.pythonClassParameters = 'pythonParameters'
			groups.pythonDecorator = '@preproc.python'
			groups.pythonDottedName = 'Identifier'
			groups.pythonError = '@error.python'
			groups.pythonException = '@exception.python'
			groups.pythonInclude = '@include.python'
			groups.pythonIndentError = 'pythonError'
			groups.pythonLambdaExpr = 'pythonOperator'
			groups.pythonOperator = '@operator.python'
			groups.pythonParam = '@parameter.python'
			groups.pythonParameters = '@parameter.python'
			groups.pythonRun = '@preproc.python'
			groups.pythonSelf = '@keyword.python'
			groups.pythonSpaceError = 'pythonError'
			groups.pythonStatement = '@keyword.python'
		end

		if all_syntax or syntax.razor ~= false then
			groups.razorCode = '@preproc.razor'
			groups.razorMemberAccessOperator = '@punctuation.delimiter.razor'
			groups.razorcsAccessor = '@operator.cs'
			groups.razorcsAttribute = '@attribute.cs'
			groups.razorcsAttributeDelimiter = 'razorcsAttribute'
			groups.razorcsLHSMemberAccessOperator = '@punctuation.delimiter.cs'
			groups.razorcsModifier = '@keyword.cs'
			groups.razorcsRHSMemberAccessOperator = 'razorcsLHSMemberAccessOperator'
			groups.razorcsStringDelimiter = 'razorhtmlValueDelimiter'
			groups.razorcsTypeNullable = 'Special'
			groups.razorcsUnaryOperatorKeyword = '@operator.razor'
			groups.razorcsXMLTag = '@tag.xml'
			groups.razorDelimiter = '@character.special.razor'
			groups.razorEventAttribute = '@preproc.conditional.razor'
			groups.razorFor = 'razorIf'
			groups.razorhtmlAttribute = '@field.html'
			groups.razorhtmlAttributeOperator = '@operator.html'
			groups.razorhtmlTag = '@tag.html'
			groups.razorhtmlValueDelimiter = 'Delimiter'
			groups.razorIf = '@preproc.conditional.razor'
			groups.razorImplicitExpression = 'PreProc'
			groups.razorLine = 'Constant'
			groups.razorUsing = 'Include'
		end

		if all_syntax or syntax.ruby ~= false then
			groups.rubyClass = 'Structure'
			groups.rubyDefine = 'Define'
			groups.rubyInterpolationDelimiter = 'Delimiter'
		end

		if all_syntax or syntax.rust ~= false then
			groups.rustAssert = '@debug.rust'
			groups.rustCharacterDelimiter = '@punctuation.bracket.rust'
			groups.rustIdentifier = '@variable.rust'
			groups.rustStaticLifetime = '@storageclass.rust'
			groups.rustStringDelimiter = 'rustCharacterDelimiter'
			groups.rustUnused = '@character.special.rust'
			groups.rustEscape = '@string.escape.rust'
		end

		if all_syntax or syntax.scala ~= false then
			groups.scalaKeyword = 'Keyword'
			groups.scalaNameDefinition = 'Identifier'
		end

		if all_syntax or syntax.scss ~= false then
			groups.scssAmpersand = '@variable.builtin.scss'
			groups.scssAttribute = '@punctuation'
			groups.scssBoolean = 'Boolean'
			groups.scssDefault = 'Keyword'
			groups.scssDefinition = '@preproc.conditional.scss'
			groups.scssElse = 'scssIf'
			groups.scssIf = '@preproc.conditional.scss'
			groups.scssInclude = '@include.scss'
			groups.scssMixinName = '@lsp.type.interface.scss'
			groups.scssSelectorChar = '@punctuation.delimiter.scss'
			groups.scssSelectorName = '@structure.scss'
			groups.scssVariable = '@define.scss'
			groups.scssVariableAssignment = '@operator.scss'
		end

		if all_syntax or syntax.sh ~= false then
			groups.shDerefSimple = '@variable.sh'
			groups.shDeref = 'shDerefSimple'
			groups.shDerefVarArray = '@field.sh'
			groups.shOption = '@parameter.sh'
			groups.shFunctionKey = '@function.sh'
			groups.shLoop = '@repeat.sh'
			groups.shParen = '@punctuation.bracket.sh'
			groups.shQuote = '@punctuation.delimiter.sh'
			groups.shSet = 'Statement'
			groups.shTestOpr = '@debug.sh'
		end

		if all_syntax or syntax.solidity ~= false then
			groups.solBuiltinType = '@type.builtin.solidity'
			groups.solContract = '@type.solidity'
			groups.solContractName = '@function.solidity'
		end

		if all_syntax or syntax.sql ~= false then
			groups.sqlKeyword = '@keyword.sql'
			groups.sqlParen = '@punctuation.bracket.sql'
			groups.sqlSpecial = '@constant.sql'
			groups.sqlStatement = 'Statement'
			groups.sqlParenFunc = '@function.sql'
		end

		if all_syntax or syntax.tex ~= false then
			groups.texMathRegion = '@number.tex'
			groups.texMathSub = '@number.tex'
			groups.texMathSuper = '@number.tex'
			groups.texMathRegionX = '@number.tex'
			groups.texMathRegionXX = '@number.tex'
		end

		if all_syntax or syntax.toml ~= false then
			groups.tomlComment = '@comment.toml'
			groups.tomlDate = '@string.special.toml'
			groups.tomlFloat = '@float.toml'
			groups.tomlKey = '@field.toml'
			groups.tomlTable = '@structure.toml'
		end

		if all_syntax or syntax.vim ~= false then
			groups.vimAddress = '@character.special.vim'
			groups.vimAutoCmd = '@keyword.coroutine.vim'
			groups.vimAutoEvent = '@event.vim'
			groups.vimCmdSep = '@punctuation.delimiter.vim'
			groups.vimCommand = '@keyword.vim'
			groups.vimEchoHLNone = '@constant.vim'
			groups.vimEscape = '@string.escape.vim'
			groups.vimFgBgAttrib = '@keyword.vim'
			groups.vimFuncName = '@function.builtin.vim'
			groups.vimFunction = '@function.vim'
			groups.vimGroup = '@structure.builtin.vim'
			groups.vimHiAttrib = '@keyword.vim'
			groups.vimHiBlend = 'vimHiCterm'
			groups.vimHiCterm = '@field.vim'
			groups.vimHiCtermFgBg = 'vimHiCterm'
			groups.vimHiGroup = '@structure.vim'
			groups.vimHiGui = 'vimHiCterm'
			groups.vimHiGuiFgBg = 'vimHiGui'
			groups.vimHiKeyList = '@punctuation.delimiter.vim'
			groups.vimIsCommand = '@variable.vim'
			groups.vimLet = '@keyword'
			groups.vimOption = 'vimSet'
			groups.vimScriptDelim = 'Ignore'
			groups.vimSet = '@variable.builtin'
			groups.vimSetEqual = '@operator.vim'
			groups.vimSetSep = '@punctuation.delimiter.vim'
			groups.vimUserFunc = '@function.vim'
		end

		if all_syntax or syntax.xdefaults ~= false then
			groups.xdefaultsLabel = '@field.xdefaults'
			groups.xdefaultsPunct = '@punctuation.delimiter.xdefaults'
			groups.xdefaultsValue = '@string.xdefaults'
		end

		if all_syntax or syntax.xml ~= false then
			groups.xmlAttrib = '@tag.attribute.xml'
			groups.xmlEndTag = 'xmlTag'
			groups.xmlEqual = '@operator.xml'
			groups.xmlTag = '@tag.delimiter.xml'
			groups.xmlTagName = '@tag.xml'
		end

		if all_syntax or syntax.xxd ~= false then
			groups.xxdAddress = '@number.xxd'
			groups.xxdAscii = '@character.xxd'
			groups.xxdDot = 'Ignore'
			groups.xxdSep = '@punctuation.delimiter.xxd'
		end

		if all_syntax or syntax.yaml ~= false then
			groups.yamlInline = '@punctuation.delimiter.yaml'
			groups.yamlKey = '@field.yaml'
		end
	end

	return groups
end

return from_palette
