local Groups = require 'highlite.groups' --- @type highlite.Groups
local Options = require 'highlite.groups.options' --- @type highlite.groups.Options

--- resolve highlight groups being defined by links.
--- @package
--- @param groups highlite.groups the current table being indexed.
--- @param name string the key to resolve the value for.
--- @return nil|highlite.group.new # the value at `tbl[key]`, when highlight links and embedded functions have been accounted for.
local function resolve(groups, name) -- {{{
	local original_group = rawget(groups, name)

	if type(original_group) == 'string'  then
		original_group = resolve(groups, original_group)
	elseif original_group and original_group.link then
		original_group = resolve(groups, original_group.link)
	end

	return original_group
end -- }}}

--- Clear a highlight group
--- @type highlite.group.new
local NONE = {}

--- Used to allow calling a table to resolve its contents.
local RESOLVE_METATABLE = {__call = resolve}

--- Generate the default highlight groups using the `palette`.
--- @type highlite.groups.from_palette
local function from_palette(palette, opts)
	local all_nvim_plugins, any_nvim_plugins,
		all_syntax, any_syntax,
		all_vim_plugins, any_vim_plugins = Options.parse_from_palette(opts)

	local conditional = {fg = palette.conditional, italic = true}
	local define = {fg = palette.define, nocombine = true}
	local delimiter = {fg = palette.punctuation}
	local exception = {fg = palette.throw, bold = true}
	local include = {fg = palette.include, nocombine = true}
	local keyword = {fg = palette.keyword}
	local label = {fg = palette.label, bold = true}
	local macro = {fg = palette.macro, italic = true}
	local operator = {fg = palette.operator, bold = true}
	local pre_proc = {fg = palette.preproc}
	local preproc_conditional = {fg = palette.preproc_conditional, italic = true}
	local repeat_ = {fg = palette.loop, italic = true}
	local sign_column = {fg = palette.text_contrast_bg_low}
	local status_line = {fg = palette.string, bg = palette.bg_contrast_high}
	local storage_class = {fg = palette.storage, bold = true}
	local structure = {fg = palette.structure, bold = true}
	local tabline = {fg = palette.text, bg = palette.bg_contrast_high}
	local tabline_fill = {fg = palette.bg, bg = palette.bg}
	local tabline_sel = {fg = palette.text, bg = palette.bg_contrast_low, sp = palette.buffer_current, underline = true}
	local type_ = {fg = palette.type}
	local type_definition = {fg = palette.type, italic = true}

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
		Conditional = conditional,
		Debug = 'WarningMsg',
		Delimiter = delimiter,
		Exception = exception,
		Function = {fg = palette.func},
		Identifier = {fg = palette.identifier},
		Keyword = keyword,
		Label = label,
		Noise = 'Delimiter',
		Operator = operator,
		Repeat = repeat_,
		Statement = {fg = palette.statement},
		StorageClass = storage_class,
		Structure = structure,
		Type = type_,
		Typedef = type_definition,

		-- Pre-processor
		Define = define,
		Include = include,
		Macro = macro,
		PreCondit = preproc_conditional,
		PreProc = pre_proc,

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
		CursorLineNr = Groups.extend({fg = palette.number}, sign_column),
		LineNr = 'SignColumn',
		QuickFixLine = {bg = status_line.bg},
		Visual = {bg = palette.select},
		VisualNOS = 'Visual',

		-- Popups
		FloatBorder = {fg = palette.text_contrast_bg_high},
		--(FloatTitle defined below)
		NormalFloat = 'Pmenu',
		Pmenu = {fg = palette.text, bg = palette.bg_contrast_low},
		PmenuSbar = {bg = palette.bg_contrast_high},
		PmenuSel = 'Visual',
		PmenuThumb = {bg = palette.text_contrast_bg_high},
		WildMenu = 'PmenuSel',

		-- Folds
		FoldColumn = 'SignColumn',
		Folded = {fg = palette.text, bg = palette.fold, italic = true},

		-- Diffs
		DiffAdd = {fg = palette.bg, bg = palette.string},
		diffAdded = 'DiffAdd',
		DiffChange = NONE,
		DiffDelete = {fg = palette.bg, bg = palette.error},
		DiffText = {fg = palette.bg, bg = palette.diff_change},
		diffRemoved = 'DiffDelete',

		-- Jumping
		Tag = 'Underlined',
		--(MatchParen defined below)

		-- Searching
		CurSearch = 'Search',
		IncSearch = {bg = palette.search, fg = palette.bg, nocombine = true},
		Search = {sp = palette.search, underline = true},

		-- Spelling
		SpellBad = 'DiagnosticUnderlineError',
		SpellCap = 'DiagnosticUnderlineHint',
		SpellLocal = 'DiagnosticUnderlineWarn',
		SpellRare = 'DiagnosticUnderlineOk',

		-- Conditional Column Highlighting
		ColorColumn = {bg = palette.bg_contrast_high},
		SignColumn = sign_column,

		-- Messages
		Error = {bg = palette.syntax_error},
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

		DiagnosticError = {fg = palette.bg, bg = palette.error, bold = true},
		DiagnosticFloatingError = '@comment.error',
		DiagnosticSignError = 'DiagnosticFloatingError',
		DiagnosticUnderlineError = {sp = palette.error, undercurl = true},

		DiagnosticHint = {fg = palette.bg, bg = palette.hint, bold = true},
		DiagnosticFloatingHint = '@comment.hint',
		DiagnosticSignHint = 'DiagnosticFloatingHint',
		DiagnosticUnderlineHint = {sp = palette.hint, undercurl = true},

		DiagnosticInfo = {fg = palette.bg, bg = palette.info, bold = true},
		DiagnosticFloatingInfo = '@comment.info',
		DiagnosticSignInfo = 'DiagnosticFloatingInfo',
		DiagnosticUnderlineInfo = {sp = palette.info, undercurl = true},

		DiagnosticOk = {fg = palette.bg, bg = palette.ok, bold = true},
		DiagnosticFloatingOk = {fg = palette.ok},
		DiagnosticSignOk = 'DiagnosticFloatingOk',
		DiagnosticUnderlineOk = {sp = palette.ok, undercurl = true},

		DiagnosticWarn = {fg = palette.bg, bg = palette.warning, bold = true},
		DiagnosticFloatingWarn = '@comment.warning',
		DiagnosticSignWarn = 'DiagnosticFloatingWarn',
		DiagnosticUnderlineWarn = {sp = palette.warning, undercurl = true},

		DiagnosticUnnecessary = {sp = palette.text_contrast_bg_low, underdotted = true},

		-- Cursor
		Cursor = {bg = palette.text_contrast_bg_high, fg = palette.bg},
		CursorIM = 'Cursor',
		CursorColumn = {bg = palette.bg_contrast_low},

		-- Misc
		Directory = '@module',
		MsgSeparator = {bg = palette.text_contrast_bg_high},
		WinSeparator = {fg = palette.text_contrast_bg_high},

		--[[ Syntax (LSP / TreeSitter) ]]

		-- LSP
		['@lsp.mod.annotation'] = {fg = palette.annotation, nocombine = true},
		['@lsp.mod.constant'] = '@constant',
		['@lsp.mod.interpolation'] = '@string.special',
		['@lsp.mod.readonly'] = '@lsp.mod.constant',
		['@lsp.mod.static'] = {italic = true},
		['@lsp.type.boolean'] = '@boolean',
		['@lsp.type.character'] = '@character',
		['@lsp.type.class'] = {fg = palette.class, bold = true, nocombine = true},
		['@lsp.type.decorator'] = {fg = palette.decorator},
		['@lsp.type.enum'] = {fg = palette.enum, bold = true, nocombine = true},
		['@lsp.type.enumMember'] = {fg = palette.field_enum, nocombine = true},
		['@lsp.type.escapeSequence'] = '@string.escape',
		['@lsp.type.event'] = '@event',
		['@lsp.type.float'] = '@number.float',
		['@lsp.type.identifier'] = 'Identifier',
		['@lsp.type.interface'] = {fg = palette.interface, nocombine = true},
		['@lsp.type.keyword'] = '@keyword',
		['@lsp.type.lifetime'] = '@keyword.storage.lifetime',
		['@lsp.type.macro'] = '@macro',
		['@lsp.type.method'] = '@function.method',
		['@lsp.type.namespace'] = '@module',
		['@lsp.type.number'] = '@number',
		['@lsp.type.operator'] = NONE,
		['@lsp.type.parameter'] = '@variable.parameter',
		['@lsp.type.property'] = '@property',
		['@lsp.type.string'] = '@string',
		['@lsp.type.struct'] = '@structure',
		['@lsp.type.type'] = '@type',
		['@lsp.type.typeAlias'] = '@type.definition',
		['@lsp.type.typeParameter'] = {fg = palette.type_parameter, italic = true, nocombine = true},
		['@lsp.type.variable'] = '@variable',
		['@lsp.typemod.deriveHelper.attribute'] = '@attribute',
		['@lsp.typemod.function.defaultLibrary'] = '@function.builtin',
		['@lsp.typemod.string.constant'] = NONE,
		['@lsp.typemod.string.readonly'] = NONE,
		['@lsp.typemod.string.static'] = NONE,
		['@lsp.typemod.type.declaration'] = '@type.definition',
		['@lsp.typemod.type.defaultLibrary'] = '@type.builtin',
		['@lsp.typemod.type.readonly'] = '@lsp.type.type',
		['@lsp.typemod.variable.defaultLibrary'] = '@variable.builtin',
		LspInlayHint = '@comment.documentation',

		-- Treesitter
		-- HACK: a lot of these have `nocombine` because of overly-eager captures
		--       in many built-in highlight queries.
		--(@keyword.debug defined below)
		['@attribute'] = {fg = palette.attribute, nocombine = true},
		['@character.special'] = {fg = palette.character_special, bold = true},
		['@comment.documentation'] = {fg = palette.comment_documentation},
		['@comment.error'] = {fg = palette.error},
		['@comment.hint'] = {fg = palette.hint},
		['@comment.info'] = {fg = palette.info},
		['@comment.todo'] = {fg = palette.todo},
		['@comment.warning'] = {fg = palette.warning},
		['@conceal'] = 'Conceal',
		['@constant.builtin'] = {fg = palette.constant_builtin, bold = true, nocombine = true},
		['@constructor'] = {fg = palette.constructor, nocombine = true},
		['@diff.delta'] = {fg = palette.diff_change},
		['@diff.minus'] = {fg = palette.diff_delete},
		['@diff.plus'] = {fg = palette.diff_add},
		['@error'] = 'Error',
		['@event'] = {fg = palette.event, nocombine = true},
		['@function.builtin'] = {fg = palette.func_builtin, italic = true},
		['@function.macro'] = '@macro',
		['@function.method'] = {fg = palette.method, nocombine = true},
		['@keyword'] = Groups.extend({nocombine = true}, keyword),
		['@keyword.conditional'] = Groups.extend({nocombine = true}, conditional),
		['@keyword.coroutine'] = {fg = palette.keyword_coroutine, nocombine = true},
		['@keyword.directive'] = Groups.extend({nocombine = true}, pre_proc),
		['@keyword.directive.conditional'] = Groups.extend({nocombine = true}, preproc_conditional),
		['@keyword.directive.define'] = Groups.extend({nocombine = true}, define),
		['@keyword.exception'] = Groups.extend({nocombine = true}, exception),
		['@keyword.function'] = {fg = palette.keyword_function, nocombine = true},
		['@keyword.import'] = Groups.extend({nocombine = true}, include),
		['@keyword.operator'] = {fg = palette.keyword_operator, bold = true, nocombine = true},
		['@keyword.repeat'] = Groups.extend({nocombine = true}, repeat_),
		['@keyword.return'] = {fg = palette.keyword_return, nocombine = true},
		['@keyword.storage'] = Groups.extend({nocombine = true}, storage_class),
		['@keyword.storage.lifetime'] = {fg = palette.storage},
		['@label'] = Groups.extend({nocombine = true}, label),
		['@macro'] = Groups.extend({nocombine = true}, macro),
		['@markup'] = {fg = palette.text},
		['@markup.emphasis'] = 'Italic',
		['@markup.environment'] = {fg = palette.text_environment, nocombine = true},
		['@markup.environment.name'] = {fg = palette.text_environment_name, nocombine = true},
		['@markup.heading.1'] = {fg = palette.error, bold = true},
		['@markup.heading.1.marker'] = '@punctuation.special',
		['@markup.heading.2'] = {fg = palette.warning, bold = true},
		['@markup.heading.2.marker'] = '@markup.heading.1.marker',
		['@markup.heading.3'] = {fg = palette.diff_change, bold = true},
		['@markup.heading.3.marker'] = '@markup.heading.1.marker',
		['@markup.heading.4'] = {fg = palette.string, bold = true},
		['@markup.heading.4.marker'] = '@markup.heading.1.marker',
		['@markup.heading.5'] = {fg = palette.type, bold = true},
		['@markup.heading.5.marker'] = '@markup.heading.1.marker',
		['@markup.heading.6'] = {fg = palette.fold, bold = true},
		['@markup.heading.6.marker'] = '@markup.heading.1.marker',
		['@markup.link'] = {fg = palette.text_reference, underline = true},
		['@markup.link.label'] = '@string.special' ,
		['@markup.link.url'] = '@string.special.url',
		['@markup.list'] = '@punctuation.special',
		['@markup.math'] = {fg = palette.text_math},
		['@markup.quote'] = '@comment',
		['@markup.raw'] = {fg = palette.text_literal, nocombine = true},
		['@markup.strike'] = {strikethrough = true},
		['@markup.strong'] = 'Bold',
		['@markup.underline'] = {underline = true},
		['@module'] = {fg = palette.namespace, bold = true, nocombine = true},
		['@operator'] = Groups.extend({nocombine = true}, operator),
		['@property'] = {fg = palette.property, nocombine = true},
		['@punctuation'] = Groups.extend({nocombine = true}, delimiter),
		['@punctuation.bracket'] = {fg = palette.punctuation_bracket, nocombine = true},
		['@punctuation.delimiter'] = {fg = palette.punctuation_delimiter, nocombine = true},
		['@punctuation.special'] = {fg = palette.punctuation_special, nocombine = true},
		['@string.documentation'] = '@comment.documentation',
		['@string.escape'] = {fg = palette.string_escape, italic = true, nocombine = true},
		['@string.keycode'] = 'SpecialKey',
		['@string.regexp'] = {fg = palette.string_regex, nocombine = true},
		['@string.special'] = {fg = palette.string_special, nocombine = true},
		['@structure'] = Groups.extend({nocombine = true}, structure),
		['@tag'] = {fg = palette.tag, bold = true, nocombine = true},
		['@tag.attribute'] = {fg = palette.tag_attribute, nocombine = true},
		['@tag.delimiter'] = {fg = palette.tag_delimiter, nocombine = true},
		['@type'] = Groups.extend({nocombine = true}, type_),
		['@type.builtin'] = {fg = palette.type_builtin, nocombine = true},
		['@type.definition'] = Groups.extend({nocombine = true}, type_definition),
		['@type.qualifier'] = '@keyword',
		['@variable'] = {fg = palette.variable, nocombine = true},
		['@variable.builtin'] = {fg = palette.variable_builtin, italic = true, nocombine = true},
		['@variable.member'] = {fg = palette.field, nocombine = true},
		['@variable.parameter'] = {fg = palette.parameter, italic = true, nocombine = true},

		-- HACK: these should be automatically derived, but treesitter breaking changes forces them to be explicit for
		--       backwards compatability
		['@number.float'] = 'Float',
		['@string.special.url'] = 'Underlined',

		-- NOTE: these are deprecated groups; they should be removed in the future
		['@conditional'] = '@keyword.conditional',
		['@debug'] = '@keyword.debug',
		['@define'] = '@keyword.directive.define',
		['@exception'] = '@keyword.exception',
		['@field'] = '@variable.member',
		['@float'] = '@number.float',
		['@include'] = '@keyword.import',
		['@method'] = '@function.method',
		['@namespace'] = '@module',
		['@parameter'] = '@variable.parameter',
		['@preproc'] = '@keyword.directive',
		['@preproc.conditional'] = '@keyword.directive.conditional',
		['@repeat'] = '@keyword.repeat',
		['@storageclass'] = '@keyword.storage',
		['@storageclass.lifetime'] = '@keyword.storage.lifetime',
		['@string.regex'] = '@string.regexp',
		['@text'] = '@markup',
		['@text.danger'] = '@comment.error',
		['@text.diff.add'] = '@diff.plus',
		['@text.diff.change'] = '@diff.delta',
		['@text.diff.delete'] = '@diff.minus',
		['@text.emphasis'] = '@markup.emphasis',
		['@text.environment'] = '@markup.environment',
		['@text.environment.name'] = '@markup.environment.name',
		['@text.literal'] = '@markup.raw',
		['@text.math'] = '@markup.math',
		['@text.note'] = '@comment.info',
		['@text.quote'] = '@markup.quote',
		['@text.reference'] = '@markup.link',
		['@text.strike'] = '@markup.strike',
		['@text.strong'] = '@markup.strong',
		['@text.title.1'] = '@markup.heading.1',
		['@text.title.2'] = '@markup.heading.2',
		['@text.title.3'] = '@markup.heading.3',
		['@text.title.4'] = '@markup.heading.4',
		['@text.title.5'] = '@markup.heading.5',
		['@text.title.6'] = '@markup.heading.6',
		['@text.todo'] = '@comment.todo',
		['@text.underline'] = '@markup.underline',
		['@text.uri'] = '@string.special.url',
		['@text.warning'] = '@comment.warning',

		-- C
		['@type.qualifier.c'] = '@keyword.storage.c',

		-- C++
		['@type.qualifier.cpp'] = '@keyword.storage.cpp',

		-- C#
		['@lsp.type.keyword.cs'] = NONE,

		-- Dart
		['@lsp.type.string.dart'] = NONE,

		-- Go
		['@lsp.type.keyword.go'] = NONE,
		['@lsp.type.number.go'] = NONE,
		['@lsp.type.operator.go'] = NONE,
		['@lsp.typemod.variable.defaultLibrary.go'] = NONE,

		-- Lua
		['@constructor.lua'] = '@structure.lua',
		['@lsp.typemod.function.declaration.lua'] = '@lsp.type.function.lua',
		['@lsp.typemod.function.global.lua'] = '@lsp.type.function.lua',
		['@lsp.typemod.variable.defaultLibrary.lua'] = '@lsp.type.struct.lua',
		['@lsp.typemod.variable.definition.lua'] = '@variable.builtin.lua',
		['@module.builtin.lua'] = '@structure.lua',

		-- Rust
		['@lsp.mod.callable.rust'] = '@lsp.type.function.rust',
		['@lsp.type.builtinType.rust'] = '@type.builtin.rust',
		['@lsp.type.character.rust'] = NONE,
		['@lsp.type.decorator.rust'] = '@keyword.directive.rust',
		['@lsp.type.derive.rust'] = '@macro.rust',
		['@lsp.type.enumMember.rust'] = '@type',
		['@lsp.type.keyword.rust'] = NONE,
		['@lsp.type.macro.rust'] = NONE,
		['@lsp.type.operator.rust'] = NONE,
		['@lsp.type.selfKeyword.rust'] = '@variable.builtin.rust',
		['@lsp.type.selfTypeKeyword.rust'] = '@lsp.type.typeAlias.rust',
		['@lsp.type.string.rust'] = NONE,
		['@lsp.type.variable.rust'] = NONE,
		['@lsp.typemod.enumMember.defaultLibrary.rust'] = '@type.builtin',
		['@lsp.typemod.keyword.injected.rust'] = '@keyword.rust',
		['@lsp.typemod.macro.injected.rust'] = '@macro.rust',
		['@lsp.typemod.operator.attribute.rust'] = '@operator.rust',
		['@lsp.typemod.operator.injected.rust'] = '@operator.rust',
		['@lsp.typemod.string.injected.rust'] = '@string.rust',
		['@lsp.typemod.variable.defaultLibrary.rust'] = NONE,
		['@lsp.typemod.variable.injected.rust'] = '@variable.rust',
		['@type.qualifier.rust'] = '@keyword.storage.rust',

		-- TypeScript
		['@type.qualifier.typescript'] = '@keyword.storage.c',
	} -- }}}

	setmetatable(groups, RESOLVE_METATABLE)

	groups.FloatTitle = Groups.extend({bold = true}, groups'FloatBorder')
	groups.MatchParen = Groups.extend({bold = true}, groups'Tag')
	groups['@keyword.debug'] = Groups.extend({nocombine = true}, groups'Debug')
	groups['@lsp.type.constParameter'] = Groups.extend(Groups.clone(groups'Constant'), groups'@variable.parameter')
	groups['@lsp.typemod.interface.defaultLibrary'] = Groups.extend({fg = palette.builtin}, groups'@type.builtin')

	if any_nvim_plugins then
		local nvim_plugins = type(opts.plugins) == 'table' and opts.plugins.nvim or NONE

		if all_nvim_plugins or nvim_plugins.aerial ~= false then
			groups.AerialBooleanIcon = '@boolean.aerial'
			groups.AerialClassIcon = '@lsp.type.class.aerial'
			groups.AerialConstructorIcon = '@constructor.aerial'
			groups.AerialEnumIcon = '@lsp.type.enum.aerial'
			groups.AerialEnumMemberIcon = '@lsp.type.enumMember.aerial'
			groups.AerialEventIcon = '@event.aerial'
			groups.AerialFieldIcon = '@variable.member.aerial'
			groups.AerialFileIcon = 'Directory'
			groups.AerialInterfaceIcon = '@lsp.type.interface.aerial'
			groups.AerialKeyIcon = '@variable.member.aerial'
			groups.AerialMethodIcon = '@function.method.aerial'
			groups.AerialNamespaceIcon = '@module.aerial'
			groups.AerialNullIcon = '@constant.builtin.aerial'
			groups.AerialNumberIcon = '@number.aerial'
			groups.AerialOperatorIcon = '@operator.aerial'
			groups.AerialPropertyIcon = '@property.aerial'
			groups.AerialStringIcon = '@string.aerial'
			groups.AerialStructIcon = '@structure.aerial'
			groups.AerialTypeParameterIcon = '@lsp.type.typeParameter.aerial'
			groups.AerialVariableIcon = '@variable.aerial'
		end

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
			groups.CmpItemKindField = '@variable.member'
			groups.CmpItemKindFile = 'Directory'
			groups.CmpItemKindFolder = 'CmpItemKindFile'
			groups.CmpItemKindFunction = '@function'
			groups.CmpItemKindInterface = '@lsp.type.interface'
			groups.CmpItemKindKeyword = '@keyword'
			groups.CmpItemKindMethod = '@function.method'
			groups.CmpItemKindModule = '@module'
			groups.CmpItemKindOperator = '@operator'
			groups.CmpItemKindProperty = '@property'
			groups.CmpItemKindReference = '@keyword.storage'
			groups.CmpItemKindSnippet = 'Special'
			groups.CmpItemKindStruct = '@structure'
			groups.CmpItemKindText = '@string'
			groups.CmpItemKindTypeParameter = '@lsp.type.typeParameter'
			groups.CmpItemKindUnit = 'Special'
			groups.CmpItemKindValue = '@constant'
			groups.CmpItemKindVariable = '@variable'
		end

		if all_nvim_plugins or nvim_plugins.fzf ~= false then
			groups.FzfLuaBorder = 'FloatBorder'
			groups.FzfLuaTitle = 'FloatTitle'
		end

		if all_nvim_plugins or nvim_plugins.gitsigns ~= false then
			groups.GitSignsAdd = '@diff.plus'
			groups.GitSignsChange = '@diff.delta'
			groups.GitSignsDelete = '@diff.minus'
		end

		if all_nvim_plugins or nvim_plugins.indent_blankline ~= false then
			groups.IblIndent = 'IndentBlanklineChar'
			groups.IblWhitespace = 'IndentBlanklineChar'
			groups.IndentBlanklineChar = Groups.extend({nocombine = true}, groups 'Whitespace')
			groups.IndentBlanklineSpaceChar = 'IndentBlanklineChar'
		end

		if all_nvim_plugins or nvim_plugins.lazy ~= false then
			groups.LazyButton = 'TabLine'
			groups.LazyButtonActive = 'TabLineSel'
			groups.LazyCommit = '@number.lazy'
			groups.LazyCommitIssue = 'LazyUrl'
			groups.LazyCommitType = '@type.lazy'
			groups.LazyDir = 'Directory'
			groups.LazyH1 = '@markup.heading.1'
			groups.LazyH2 = '@markup.heading.2'
			groups.LazyProp = '@variable.member.lazy'
			groups.LazyReasonEvent = '@keyword.repeat.lazy'
			groups.LazyReasonFt = '@keyword.conditional.lazy'
			groups.LazyReasonImport = '@function.lazy'
			groups.LazyReasonKeys = '@string.lazy'
			groups.LazyReasonPlugin = '@label.lazy'
			groups.LazyReasonSource = '@keyword.import.lazy'
			groups.LazyReasonStart = '@constant.lazy'
			groups.LazySpecial = 'Special'
			groups.LazyTaskOutput = 'Statement'
			groups.LazyUrl = '@string.special.url.lazy'
		end

		if all_nvim_plugins or nvim_plugins.leap ~= false then
			groups.LeapLabelPrimary = {bold = true, reverse = true}
			groups.LeapLabelSecondary = Groups.extend({bold = true}, groups'IncSearch')
			groups.LeapLabelSelected = 'Visual'
		end

		if all_nvim_plugins or nvim_plugins.lsp_signature ~= false then
			groups.LspSignatureActiveParameter = 'Visual'
		end

		if all_nvim_plugins or nvim_plugins.lspconfig ~= false then
			groups.LspInfoBorder = 'FloatBorder'
			groups.LspInfoList = '@markup.raw'
			groups.LspInfoTip = '@comment.info.lspinfo'
			groups.LspInfoTitle = 'FloatTitle'
		end

		if all_nvim_plugins or nvim_plugins.lspsaga ~= false then
			groups.DefinitionCount = 'Number'
			groups.DefinitionIcon = 'Special'
			groups.ReferencesCount = 'Number'
			groups.ReferencesIcon = 'DefinitionIcon'
			groups.TargetFileName = 'Directory'
			groups.TargetWord = '@markup.title'
		end

		if all_nvim_plugins or nvim_plugins.mini ~= false then
			groups.MiniJump = {sp = palette.search, underdouble = true}
			groups.MiniJump2dSpot = {bold = true, reverse = true}
			groups.MiniSurround = {reverse = true}
		end

		if all_nvim_plugins or nvim_plugins.nvim_tree ~= false then
			groups.NvimTreeRootFolder = '@markup.title.NvimTree'
			groups.NvimTreeGitDeleted = '@diff.minus.NvimTree'
			groups.NvimTreeGitDirty = {fg = palette.warning}
			groups.NvimTreeGitIgnored = 'Ignore'
			groups.NvimTreeGitMerge = 'NvimTreeGitRenamed'
			groups.NvimTreeGitNew = '@diff.plus.NvimTree'
			groups.NvimTreeGitRenamed = '@diff.delta.NvimTree'
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

		if all_nvim_plugins or nvim_plugins.sniprun ~= false then
			groups.SniprunFloatingWinErr = 'DiagnosticFloatingError'
			groups.SniprunFloatingWinOk = 'DiagnosticFloatingOk'
			groups.SniprunVirtualTextError = 'DiagnosticVirtualTextError'
			groups.SniprunVirtualTextOk = 'DiagnosticVirtualTextOk'
		end

		if all_nvim_plugins or nvim_plugins.symbols_outline ~= false then
			groups.FocusedSymbol = NONE
			groups.SymbolsOutlineConnector = 'Delimiter'
		end

		if all_nvim_plugins or nvim_plugins.telescope ~= false then
			groups.TelescopeBorder = 'FloatBorder'
			groups.TelescopeNormal = 'NormalFloat'
			groups.TelescopePromptCounter = '@number.TelescopePrompt'
			groups.TelescopeTitle = 'FloatTitle'
		end

		if all_nvim_plugins or nvim_plugins.todo_comments ~= false then
			groups.TodoFgFIX = '@comment.error'
			groups.TodoFgHACK = '@diff.delta'
			groups.TodoFgNOTE = '@comment.info'
			groups.TodoFgPERF = {fg = palette.ok}
			groups.TodoFgTEST = {fg = palette.hint}
			groups.TodoFgTODO = '@comment.todo'
			groups.TodoFgWARN = '@comment.warning'

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
		local vim_plugins = type(opts.plugins) == 'table' and opts.plugins.vim or NONE

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

		if all_vim_plugins or vim_plugins.easymotion ~= false then
			groups.EasyMotion = {bold = true, reverse = true}
		end

		if all_vim_plugins or vim_plugins.fern ~= false then
			groups.FernBranchText = 'Directory'
		end

		if all_vim_plugins or vim_plugins.gitgutter ~= false then
			groups.GitGutterAdd = '@diff.plus'
			groups.GitGutterChange = '@diff.delta'
			groups.GitGutterDelete = '@diff.minus'
			groups.GitGutterChangeDelete = 'GitGutterChange'
		end

		if all_vim_plugins or vim_plugins.indent_guides ~= false then
			groups.IndentGuidesOdd = {bg = palette.bg_contrast_high}
			groups.IndentGuidesEven = {bg = palette.text_contrast_bg_low}
		end

		if all_vim_plugins or vim_plugins.jumpmotion ~= false then
			groups.JumpMotion = {bold = true, reverse = true}
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

		if all_vim_plugins or vim_plugins.sandwich ~= false then
			groups.OperatorSandwichChange = 'DiffText'
		end

		if all_vim_plugins or vim_plugins.signify ~= false then
			groups.SignifySignAdd = '@diff.plus'
			groups.SignifySignChange = '@diff.delta'
			groups.SignifySignDelete = '@diff.minus'
			groups.SignifySignChangeDelete = 'SignifySignChange'
		end

		if all_vim_plugins or vim_plugins.swap ~= false then
			groups.SwapCurrentItem = 'Visual'
			groups.SwapSelectedItem = 'IncSearch'
		end

		if all_vim_plugins or vim_plugins.undotree ~= false then
			groups.UndotreeBranch = '@punctuation.delimiter.undotree'
			groups.UndotreeCurrent = '@markup.title.undotree'
			groups.UndotreeSeq = '@number.undotree'
			groups.UndotreeNode = '@character.special.undotree'
			groups.UndotreeTimeStamp = '@string.special.undotree'
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
			groups.cppSTLexception = '@keyword.exception.cpp'
			groups.cppSTLnamespace = '@module.cpp'
		end

		if all_syntax or syntax.cs ~= false then
			groups.csAccessModifier = '@keyword.cs'
			groups.csAccessor = 'csLogicSymbols'
			groups.csBraces = '@punctuation.bracket.cs'
			groups.csClass = 'csAccessModifier'
			groups.csClassType = '@lsp.type.class.cs'
			groups.csContextualStatement = '@keyword.conditional.cs'
			groups.csEndColon = '@punctuation.delimiter.cs'
			groups.csGeneric = '@lsp.type.typeParameter.cs'
			groups.csInterpolation = '@string.special.cs'
			groups.csInterpolationDelimiter = '@punctuation.special.cs'
			groups.csLogicSymbols = '@operator.cs'
			groups.csModifier = '@keyword.storage.cs'
			groups.csNew = 'csLogicSymbols'
			groups.csNewType = '@type.cs'
			groups.csParens = 'csBraces'
			groups.csPreCondit = '@keyword.directive.conditional.cs'
			groups.csQuote = 'csEndColon'
			groups.csRepeat = '@keyword.repeat.cs'
			groups.csStorage = 'csAccessModifier'
			groups.csUnspecifiedStatement = 'csModifier'
			groups.csXmlTag = 'xmlTagName'
		end

		if all_syntax or syntax.css ~= false then
			groups.cssAtRule = '@keyword.directive.conditional.css'
			groups.cssAttr = '@keyword.css'
			groups.cssAttrComma = '@punctuation.delimiter.css'
			groups.cssAttributeSelector = '@variable.member.html'
			groups.cssAttrRegion = '@keyword.css'
			groups.cssBraces = 'Delimiter'
			groups.cssClassName = '@lsp.type.class.css'
			groups.cssClassNameDot = 'cssAttrComma'
			groups.cssColor = '@string.css'
			groups.cssFlexibleBoxAttr = 'cssAttr'
			groups.cssFunctionComma = 'cssAttrComma'
			groups.cssIdentifier = '@label.css'
			groups.cssNoise = '@punctuation.css'
			groups.cssProp = '@variable.member.css'
			groups.cssPseudoClass = '@type.builtin'
			groups.cssPseudoClassId = '@keyword.css'
			groups.cssSelectorOp = '@operator.css'
			groups.cssSelectorOp2 = 'cssSelectorOp'
			groups.cssTagName = '@tag.html'
			groups.cssUIProp = 'cssProp'
			groups.cssUnitDecorators = '@type.css'
			groups.cssVendor = '@keyword.directive.css'
		end

		if all_syntax or syntax.dart ~= false then
			groups.dartClassDecl = 'dartStatement'
			groups.dartSpecialChar = '@string.escape.dart'
			groups.dartInterpolation = '@string.special'
			groups.dartLibrary = 'dartStatement'
			groups.dartStatement = '@keyword.dart'
			groups.dartUri = '@module.dart'
		end

		if all_syntax or syntax.dosini ~= false then
			groups.dosiniHeader = '@structure.dosini'
			groups.dosiniLabel = '@variable.member.dosini'
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
			groups.gitcommitSummary = '@markup.title.gitcommitSummary'
			groups.gitcommitUntrackedFile = 'gitcommitSelectedFile'

			groups.gitconfigAssignment = 'String'
			groups.gitconfigEscape = '@string.escape'
			groups.gitconfigNone = 'Operator'
			groups.gitconfigSection = '@structure.gitconfig'
			groups.gitconfigVariable = '@variable.member.gitconfig'

			groups.gitrebaseBreak = '@keyword.gitrebase'
			groups.gitrebaseCommit = '@number.gitrebase'
			groups.gitrebaseDrop = '@keyword.exception.gitrebase'
			groups.gitrebaseEdit = '@keyword.directive.define.gitrebase'
			groups.gitrebaseExec = '@keyword.directive.gitrebase'
			groups.gitrebaseFixup = 'gitrebaseSquash'
			groups.gitrebaseMerge = '@keyword.directive.gitrebase'
			groups.gitrebasePick = '@keyword.import.gitrebase'
			groups.gitrebaseReset = 'gitrebaseLabel'
			groups.gitrebaseReword = 'gitrebasePick'
			groups.gitrebaseSquash = '@macro.gitrebase'
			groups.gitrebaseSummary = '@markup.title.gitrebaseSummary'
		end

		if all_syntax or syntax.go ~= false then
			groups.goBlock = '@punctuation.bracket.go'
			groups.goBoolean = '@boolean.go'
			groups.goBuiltins = '@function.builtin.go'
			groups.goEscapeC = '@string.escape.go'
			groups.goField = '@variable.member.go'
			groups.goFloat = '@number.float.go'
			groups.goFormatSpecifier = '@string.regexp.go'
			groups.goFunction = '@function.go'
			groups.goFunctionCall = 'goFunction'
			groups.goFunctionReturn = NONE
			groups.goImport = '@keyword.import.go'
			groups.goImportString = '@module.go'
			groups.goMethodCall = 'goFunctionCall'
			groups.goPackage = 'goStatement'
			groups.goParamType = 'goReceiverType'
			groups.goPointerOperator = '@keyword.storage.go'
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
			groups.helpCommand = '@markup.raw.help'
			groups.helpHeader = '@label.help'
			groups.helpHeadline = '@markup.title.help'
			groups.helpHyperTextJump = '@string.special.url.help'
			groups.helpHyperTextEntry = 'helpHyperTextJump'
			groups.helpExample = 'helpCommand'
			groups.helpNote = 'DiagnosticHint'
			groups.helpOption = '@keyword.help'
			groups.helpSectionDelim = '@punctuation.delimiter.help'
		end

		if all_syntax or syntax.html ~= false then
			groups.htmlArg = '@tag.attribute'
			groups.htmlSpecialChar = '@string.special.html'
			groups.htmlBold = 'Bold'
			groups.htmlEndTag = 'htmlTag'
			groups.htmlH1 = '@markup.heading.1'
			groups.htmlH2 = '@markup.heading.2'
			groups.htmlH3 = '@markup.heading.3'
			groups.htmlH4 = '@markup.heading.4'
			groups.htmlH5 = '@markup.heading.5'
			groups.htmlH6 = '@markup.heading.6'
			groups.htmlItalic = 'Italic'
			groups.htmlSpecialTagName = '@keyword.html'
			groups.htmlTag = '@tag.delimiter.html'
			groups.htmlTagN = '@tag'
			groups.htmlTagName = 'htmlSpecialTagName'
			groups.htmlTitle = '@markup.title.html'
		end

		if all_syntax or syntax.i3config ~= false then
			groups.i3ConfigAction = '@function.builtin.i3config'
			groups.i3ConfigAssign = 'i3ConfigVariable'
			groups.i3ConfigAssignKeyword = '@keyword.i3config'
			groups.i3ConfigBind = '@markup'
			groups.i3ConfigBindArgument = '@variable.parameter.sh'
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
			groups.i3ConfigVariable = '@keyword.directive.define.i3config'
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
			groups.jsGlobalNodeObjects = '@keyword.import.javascript'
			groups.jsGlobalObjects = '@type.builtin.javascript'
			groups.jsObjectKey = '@type.javascript'
			groups.jsOf = '@keyword.repeat.javascript'
			groups.jsReturn = '@keyword.return.javascript'
			groups.jsSpecial = '@string.escape'
			groups.jsStorageClass = '@keyword.javascript'
			groups.jsThis = '@keyword.javascript'
			groups.jsVariableDef = '@variable.javascript'
		end

		if all_syntax or syntax.json ~= false then
			groups.jsonBraces = '@punctuation.bracket.json'
			groups.jsonEscape = '@string.escape.json'
			groups.jsonKeyword = '@variable.member.json'
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
			groups.luaFuncArgName = '@variable.parameter.lua'
			groups.luaFuncCall = '@function.call.lua'
			groups.luaFuncId = 'luaComma'
			groups.luaFuncKeyword = '@type.lua'
			groups.luaFuncName = '@function.lua'
			groups.luaFuncParens = 'luaParens'
			groups.luaFuncTable = '@structure.lua'
			groups.luaGotoLabel = '@label.lua'
			groups.luaIn = '@keyword.repeat.lua'
			groups.luaLocal = 'luaStatement'
			groups.luaNoise = '@punctuation.lua'
			groups.luaParens = '@punctuation.bracket.lua'
			groups.luaSpecialTable = '@variable.builtin.lua'
			groups.luaSpecialValue = '@function.builtin.lua'
			groups.luaStatement = '@keyword.lua'
			groups.luaStringLongTag = Groups.extend({italic = true}, groups '@punctuation.bracket')
		end

		if all_syntax or syntax.make ~= false then
			groups.makeCommands = 'Statement'
			groups.makeSpecTarget = '@type.make'
		end

		if all_syntax or syntax.man ~= false then
			groups.manHeader = '@markup.heading.1'
			groups.manOptionDesc = '@variable.parameter.sh'
			groups.manReference = '@string.special.url'
			groups.manSectionHeading = '@markup.heading.2'
			groups.manSubHeading = '@markup.heading.3'
			groups.manUnderline = '@markup.raw'
		end

		if all_syntax or syntax.markdown ~= false then
			groups.markdownCode = 'mkdCode'
			groups.markdownCodeDelimiter = 'mkdCodeDelimiter'
			groups.markdownEscape = '@string.escape.markdown'
			groups.markdownH1 = '@markup.heading.1'
			groups.markdownH2 = '@markup.heading.2'
			groups.markdownH3 = '@markup.heading.3'
			groups.markdownH4 = '@markup.heading.4'
			groups.markdownH5 = '@markup.heading.5'
			groups.markdownH6 = '@markup.heading.6'
			groups.markdownLinkDelimiter = 'mkdDelimiter'
			groups.markdownLinkText = 'mkdLink'
			groups.markdownLinkTextDelimiter = 'markdownLinkDelimiter'
			groups.markdownListMarker = 'markdownOrderedListMarker'
			groups.markdownOrderedListMarker = 'mkdListItem'
			groups.markdownSpecialChar = '@string.special.markdown'
			groups.markdownUrl = 'mkdLink'

			groups.mkdBold = '@markup.environment'
			groups.mkdBoldItalic = 'mkdBold'
			groups.mkdCode = '@markup.raw.markdown'
			groups.mkdCodeDelimiter = 'mkdBold'
			groups.mkdCodeEnd = 'mkdCodeStart'
			groups.mkdCodeStart = 'mkdCodeDelimiter'
			groups.mkdDelimiter = '@punctuation.bracket.markdown'
			groups.mkdHeading = '@punctuation.delimiter.markdown'
			groups.mkdItalic = 'mkdBold'
			groups.mkdLineBreak = 'NonText'
			groups.mkdLink = '@string.special.url.markdown'
			groups.mkdListItem = '@punctuation.special.markdown'
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
			groups.pythonDecorator = '@keyword.directive.python'
			groups.pythonDottedName = 'Identifier'
			groups.pythonError = '@error.python'
			groups.pythonException = '@keyword.exception.python'
			groups.pythonInclude = '@keyword.import.python'
			groups.pythonIndentError = 'pythonError'
			groups.pythonLambdaExpr = 'pythonOperator'
			groups.pythonOperator = '@operator.python'
			groups.pythonParam = '@variable.parameter.python'
			groups.pythonParameters = '@variable.parameter.python'
			groups.pythonRun = '@keyword.directive.python'
			groups.pythonSelf = '@keyword.python'
			groups.pythonSpaceError = 'pythonError'
			groups.pythonStatement = '@keyword.python'
		end

		if all_syntax or syntax.razor ~= false then
			groups.razorCode = '@keyword.directive.razor'
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
			groups.razorDelimiter = '@punctuation.special.razor'
			groups.razorEventAttribute = '@keyword.directive.conditional.razor'
			groups.razorFor = 'razorIf'
			groups.razorhtmlAttribute = '@variable.member.html'
			groups.razorhtmlAttributeOperator = '@operator.html'
			groups.razorhtmlTag = '@tag.html'
			groups.razorhtmlValueDelimiter = 'Delimiter'
			groups.razorIf = '@keyword.directive.conditional.razor'
			groups.razorImplicitExpression = 'PreProc'
			groups.razorLine = 'Constant'
			groups.razorUsing = 'Include'
		end

		if all_syntax or syntax.ruby ~= false then
			groups.rubyClass = '@structure.ruby'
			groups.rubyDefine = '@define.ruby'
			groups.rubyInterpolationDelimiter = '@punctuation.special'
		end

		if all_syntax or syntax.rust ~= false then
			groups.rustAssert = '@keyword.debug.rust'
			groups.rustCharacterDelimiter = '@punctuation.bracket.rust'
			groups.rustIdentifier = '@variable.rust'
			groups.rustStaticLifetime = '@keyword.storage.rust'
			groups.rustStringDelimiter = 'rustCharacterDelimiter'
			groups.rustUnused = '@variable.builtin.rust'
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
			groups.scssDefinition = '@keyword.directive.conditional.scss'
			groups.scssElse = 'scssIf'
			groups.scssIf = '@keyword.directive.conditional.scss'
			groups.scssInclude = '@keyword.import.scss'
			groups.scssMixinName = '@lsp.type.interface.scss'
			groups.scssSelectorChar = '@punctuation.delimiter.scss'
			groups.scssSelectorName = '@structure.scss'
			groups.scssVariable = '@keyword.directive.define.scss'
			groups.scssVariableAssignment = '@operator.scss'
		end

		if all_syntax or syntax.sh ~= false then
			groups.shDeref = 'shDerefSimple'
			groups.shDerefSimple = '@variable.sh'
			groups.shDerefVarArray = '@variable.member.sh'
			groups.shFunctionKey = '@function.sh'
			groups.shLoop = '@keyword.repeat.sh'
			groups.shOption = '@variable.parameter.sh'
			groups.shParen = '@punctuation.bracket.sh'
			groups.shQuote = '@punctuation.delimiter.sh'
			groups.shSet = 'Statement'
			groups.shTestOpr = '@keyword.debug.sh'
			groups.shWrapLineOperator = '@punctuation.special.sh'
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
			groups.tomlFloat = '@number.float.toml'
			groups.tomlKey = '@variable.member.toml'
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
			groups.vimHiCterm = '@variable.member.vim'
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
			groups.xdefaultsLabel = '@variable.member.xdefaults'
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
			groups.yamlKey = '@variable.member.yaml'
		end
	end

	return groups
end

return from_palette
