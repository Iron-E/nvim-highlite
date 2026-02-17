local default_groups_from_palette = require("highlite.groups.default") --- @type highlite.groups.from_palette
local Fmt = require("highlite.fmt") --- @type highlite.Fmt
local Nvim = require("highlite.nvim") --- @type highlite.Nvim
local Palette = require("highlite.color.palette") --- @type highlite.color.Palette

--- The `Fmt.string` for `Import.nvim`
local FMT = [[return
{
	terminal =
	{
		${1}, ${2}, ${3}, ${4}, ${5}, ${6}, ${7}, ${8},
		${9}, ${10}, ${11}, ${12}, ${13}, ${14}, ${15}, ${16},
	},
	palette =
	{
		annotation = ${@annotation.fg | @lsp.mod.annotation.fg},
		attribute = ${@attribute.fg},
		attribute_builtin = ${@attribute.builtin.fg},
		bg = ${Normal.bg},
		bg_contrast_high = ${NonText.fg},
		bg_contrast_low = ${CursorColumn.bg},
		boolean = ${@boolean.fg | Boolean.fg},
		buffer_active = ${BufferVisible.sp},
		buffer_alternate = ${BufferAlternate.sp},
		buffer_current = ${TabLineSel.sp},
		character = ${@character.fg | Character.fg},
		character_special = ${@character.special.fg},
		class = ${@class.fg | @lsp.type.class.fg},
		comment = ${@comment.fg | Comment.fg},
		comment_documentation = ${@comment.documentation.fg | SpecialComment.fg},
		conditional = ${@conditional.fg | @keyword.conditional.fg | Conditional.fg},
		constant = ${@constant.fg | Constant.fg},
		constant_builtin = ${@constant.builtin.fg},
		constructor = ${@constructor.fg},
		decorator = ${@decorator.fg | @lsp.type.decorator.fg},
		define = ${@define.fg | @keyword.directive.define.fg | Define.fg},
		diff_add = ${DiffAdd.bg},
		diff_change = ${DiffText.bg},
		diff_delete = ${DiffDelete.bg},
		diff_syntax_add = ${@diff.plus.fg | diffAdded.fg | Added},
		diff_syntax_change = ${@diff.delta.fg | diffChanged.fg | Changed.fg},
		diff_syntax_delete = ${@diff.minus.fg | diffRemoved.fg | Removed.fg},
		enum = ${@enum.fg | @lsp.type.enum.fg},
		error = ${DiagnosticUnderlineError.sp | @error.fg | ErrorMsg.fg | @text.danger.fg | @comment.error.fg},
		event = ${@event.fg},
		field = ${@field.fg | @variable.member.fg},
		field_enum = ${@enumMember.fg | @lsp.type.enumMember.fg},
		float = ${@float.fg | @number.float.fg | Float.fg},
		fold = ${Folded.bg | Folded.fg},
		func = ${@function.fg | @function.call.fg | Function.fg},
		func_builtin = ${@function.builtin.fg},
		heading_1 = ${@markup.heading.1.fg | @text.title.1.fg},
		heading_2 = ${@markup.heading.2.fg | @text.title.2.fg},
		heading_3 = ${@markup.heading.3.fg | @text.title.3.fg},
		heading_4 = ${@markup.heading.4.fg | @text.title.4.fg},
		heading_5 = ${@markup.heading.5.fg | @text.title.5.fg},
		heading_6 = ${@markup.heading.6.fg | @text.title.6.fg},
		hint = ${DiagnosticUnderlineHint.sp | SpellCap.sp},
		identifier = ${Identifier.fg},
		include = ${@include.fg | @keyword.import.fg | Include.fg},
		info = ${DiagnosticUnderlineInfo.sp | @text.note.fg | @comment.note.fg},
		interface = ${@interface.fg | @lsp.type.interface.fg},
		keyword = ${@keyword.fg | Keyword.fg},
		keyword_coroutine = ${@keyword.coroutine.fg},
		keyword_function = ${@keyword.function.fg},
		keyword_modifier = ${@keyword.modifier.fg},
		keyword_operator = ${@keyword.operator.fg},
		keyword_return = ${@keyword.return.fg},
		keyword_type = ${@keyword.type.fg},
		label = ${@label.fg | Label.fg},
		loop = ${@repeat.fg | @keyword.repeat.fg | Repeat.fg},
		macro = ${@macro.fg | Macro.fg},
		markup_link_label = ${@markup.link.label.fg},
		markup_list = ${@markup.list.fg},
		markup_list_checked = ${@markup.list.checked.fg},
		markup_list_unchecked = ${@markup.list.unchecked.fg},
		markup_quote = ${@markup.quote.fg | @text.quote.fg},
		message = ${ModeMsg.fg | Question.fg},
		method = ${@method.fg | @function.method.fg | @method.call.fg | @function.method.call.fg},
		namespace = ${@namespace.fg | @module.fg},
		namespace_builtin = ${@module.builtin.fg},
		number = ${@number.fg | Number.fg},
		ok = ${DiagnosticUnderlineOk.sp | SpellRare.sp},
		operator = ${@operator.fg | Operator.fg},
		parameter = ${@parameter.fg | @variable.parameter.fg},
		parameter_builtin = ${@parameter.builtin.fg},
		preproc = ${@preproc.fg | @keyword.directive.fg | PreProc.fg},
		preproc_conditional = ${PreCondit.fg},
		property = ${@property.fg | Identifier.fg},
		punctuation = ${@punctuation.fg | Delimiter.fg},
		punctuation_bracket = ${@punctuation.bracket.fg},
		punctuation_delimiter = ${@punctuation.delimiter.fg},
		punctuation_special = ${@punctuation.special.fg | @markup.list.fg},
		search = ${Search.sp | Search.bg | Search.fg},
		select = ${Visual.bg | PmenuSel.bg},
		special = ${Special.fg},
		statement = ${Statement.fg},
		storage = ${@storageclass.fg | @keyword.storage.fg | StorageClass.fg | @keyword.modifier.fg},
		string = ${@string.fg | String.fg},
		string_documentation = ${@string.documentation.fg},
		string_escape = ${@string.escape.fg},
		string_regex = ${@string.regex.fg | @string.regexp.fg},
		string_special = ${@string.special.fg | @markup.link.label.fg},
		string_special_symbol = ${@string.special.symbol.fg},
		structure = ${@structure.fg | Structure.fg},
		syntax_error = ${@error.bg | @error.fg | Error.bg | Error.fg},
		tag = ${@tag.fg},
		tag_attribute = ${@tag.attribute.fg},
		tag_delimiter = ${@tag.delimiter.fg},
		text = ${Normal.fg},
		text_contrast_bg_high = ${@punctuation.fg | Delimiter.fg},
		text_contrast_bg_low = ${@comment.fg | Comment.fg},
		text_environment = ${@text.environment.fg | @markup.environment.fg},
		text_environment_name = ${@text.environment.name.fg | @markup.environment.name.fg},
		text_literal = ${@text.literal.fg | @markup.raw.fg},
		text_math = ${@text.math.fg | @markup.math.fg},
		text_reference = ${@text.reference.fg | @markup.link.fg},
		throw = ${@exception.fg | @keyword.exception.fg | Exception.fg | @exception.bg | @keyword.exception.bg | Exception.bg},
		todo = ${Todo.bg | Todo.fg | @text.todo.bg | @comment.todo.bg | @text.todo.fg | @comment.todo.fg},
		type = ${@type.fg | Type.fg},
		type_builtin = ${@type.builtin.fg},
		type_definition = ${@type.definition.fg},
		type_parameter = ${@typeParameter.fg | @lsp.type.typeParameter.fg},
		uri = ${Underlined.fg | @text.uri.fg | @string.special.url.fg | @markup.link.url.fg},
		variable = ${@variable.fg},
		variable_builtin = ${@variable.builtin.fg},
		warning = ${DiagnosticUnderlineWarn.sp | WarningMsg.fg | @text.warning.fg | @comment.warning.fg},
	},
}]]

--- @type highlite.Fmt.string.opts
local FMT_OPTS = {
	default = vim.defaulttable(function()
		return "nil"
	end),
	loadstring_compat = true,
}

--- @param tbl highlite.import.format.return
--- @param colorscheme string
--- @param bg highlite.bg
--- @param opts highlite.Fmt.string.opts
local function import_bg(tbl, colorscheme, bg, opts)
	local load, err = loadstring(Fmt.string(FMT, opts))
	if load == nil or err then
		error(
			"Could not load formatted string for colorscheme "
				.. colorscheme
				.. " with options "
				.. vim.inspect(opts, { indent = "", newline = " " })
				.. (err == nil and "" or ": " .. err)
		)
	end

	local loaded = load()

	-- Fill in all missing values by deriving
	-- NOTE: deriving doesn't resolve all color values immediately;
	--       it only happens when indexing. we generate the default
	--       groups so that all of the color values will have been
	--       indexed at least once, thus completing the derive.
	Palette.derive(bg, loaded.palette)
	default_groups_from_palette(loaded.palette, { plugins = true, syntax = true })

	tbl[bg] = loaded
end

--- Import an *installed* Neovim colorscheme.
--- @type highlite.import.format
local function import(name, opts)
	-- NOTE: we force this plugin to load colorschemes with all groups enabled
	if name:find("^highlite") then
		require("highlite").setup()
	end

	if opts == nil then
		opts = FMT_OPTS
	else
		opts = vim.tbl_extend("force", opts, FMT_OPTS)
	end

	--- @type highlite.import.format.return
	local by_bg = {}

	Nvim.with_colorscheme(name, function()
		Nvim.with_both_bgs(function(bg)
			import_bg(by_bg, name, bg, opts)
		end)
	end)

	return by_bg
end

return import
