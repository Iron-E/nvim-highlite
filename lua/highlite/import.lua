local default_groups_from_palette = require 'highlite.groups.default' --- @type highlite.groups.from_palette
local Fmt = require 'highlite.fmt' --- @type highlite.Fmt
local Fs = require 'highlite.fs' --- @type highlite.Fs
local Palette = require 'highlite.color.palette' --- @type highlite.color.Palette
local Table = require 'highlite.table' --- @type highlite.Table
local Util = require 'highlite.utils' --- @type highlite.Utils

--- @class highlite.Import
local Import = {}

do
	--- The format for a new `:colorscheme` file
	local COLORSCHEME_FMT = [[
local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette '%s'
Highlite.generate('%s', Highlite.groups('%s', palette), terminal_palette)
]]

	--- The colorschemes native to Neovim, plus the defaults managed by in this plugin.
	local DEFAULT_IGNORED =
	{
		blue = true,
		darkblue = true,
		default = true,
		delek = true,
		desert = true,
		elflord = true,
		evening = true,
		habamax = true,
		industry = true,
		koehler = true,
		lunaperche = true,
		morning = true,
		murphy = true,
		pablo = true,
		peachpuff = true,
		quiet = true,
		retrobox = true,
		ron = true,
		shine = true,
		slate = true,
		sorbet = true,
		torte = true,
		wildcharm = true,
		zaibatsu = true,
		zellner = true,
	}

	--- @type highlite.Fmt.string.opts
	local FMT_OPTS = {convert_int_attributes = 'hex_literal'}

	local NEW_LINE = '\n\t\t\t'

	--- The format for a new color palette file
	local PALETTE_FMT = [[
--- @type highlite.color.palette.get
local function get(bg, get_terminal)
	local palette, terminal_palette
	if bg ~= 'light' then
		if get_terminal then
			terminal_palette =
			{%s
			}
		end

		palette =
		{%s
		}
	else
		if get_terminal then
			terminal_palette =
			{%s
			}
		end

		palette =
		{%s
		}
	end

	return palette, terminal_palette
end

return get
]]

	--- @type highlite.Fs.write.opts
	local WRITE_OPTIONS = {force = true, silent = true}

	--- Format a palette to insert in the `PALETTE_FMT`
	--- @package
	--- @param p highlite.color.palette
	--- @return string
	local function fmt_palette(p)
		local keys = vim.tbl_keys(p)
		table.sort(keys)

		local s = ''
		for _, color in ipairs(keys) do
			s = s .. NEW_LINE .. color .. ' = ' .. p[color] .. ','
		end

		return s
	end

	--- Format a terminal palette to insert in the `PALETTE_FMT`
	--- @package
	--- @param t highlite.color.palette.terminal
	--- @return string
	local function fmt_terminal(t)
		local s = ''
		for i, color in ipairs(t) do
			s = s .. NEW_LINE .. '\t[' .. i .. '] = ' .. color .. ','
		end

		return s
	end

	--- Import all currently installed neovim colorschemes to this repository, creating color palettes and colorscheme files
	--- for each. The built-in colorschemes (i.e. `nvim --clean`) are ignored.
	--- @private
	--- @async
	--- @param ignore? {patterns: nil|string[], raw: nil|string[]} a list of colorschemes to not import. `patterns` are passed to `getcompletion`, `raw` are given literally.
	--- @param repo_dir? string the path to the `nvim-highlite` repo on-disk
	function Import._all_nvim_to_highlite(ignore, repo_dir)
		if repo_dir == nil then
			repo_dir = vim.fs.dirname(vim.fs.dirname(vim.fs.dirname(
				vim.fs.normalize(vim.fn.fnamemodify(debug.getinfo(1, 'S').source, ':~:.'))
			)))

			if vim.startswith(repo_dir, '@') then
				repo_dir = repo_dir:sub(2)
			end
		end

		--- The place where `:colorscheme` files go
		local colors_dir = repo_dir .. '/colors/'

		--- The place where palettes go
		local groups_dir = repo_dir .. '/lua/highlite/groups/'

		--- The place where palettes go
		local palette_dir = repo_dir .. '/lua/highlite/color/palette/'

		if Table.is_empty(ignore) then ignore = {} end
		--- @cast ignore -nil

		--- The colorschemes which are configured to be ignored
		local ignored = {}

		for _, pattern in ipairs(ignore.patterns or {}) do
			for _, colorscheme in ipairs(vim.fn.getcompletion(pattern, 'color')) do
				ignored[colorscheme] = true
			end
		end

		for _, colorscheme in ipairs(ignore.raw or {}) do
			ignored[colorscheme] = true
		end

		for _, name in ipairs(vim.fn.getcompletion('*', 'color')) do
			if DEFAULT_IGNORED[name] or ignored[name] then
				goto continue -- HACK: no `continue` keyword
			end

			local imported = Import.nvim(name, FMT_OPTS)

			local palette_name
			if name:find '^highlite' then
				local colorscheme_file = colors_dir .. name .. '.lua'
				if Fs.exists_sync(colorscheme_file) then
					palette_name = Fs.read_sync(colorscheme_file)[3]:match("%b''"):sub(2, -2)
				end
			end

			if palette_name == nil then
				palette_name = name:gsub('_', '-'):lower()
			end

			Fs.write(
				palette_dir .. palette_name .. '.lua',
				PALETTE_FMT:format(
				  fmt_terminal(imported.dark.terminal),
				  fmt_palette(imported.dark.palette),
				  fmt_terminal(imported.light.terminal),
				  fmt_palette(imported.light.palette)
				),
				WRITE_OPTIONS
			)

			local colorscheme_name = name:gsub('_', '-'):lower()
			local groups_name = colorscheme_name:gsub('highlite%-', '')
			Fs.exists(groups_dir .. groups_name .. '.lua', function(exists)
				if not exists then groups_name = 'default' end

				if colorscheme_name:find '^highlite' == nil then
					colorscheme_name = 'highlite-' .. colorscheme_name
				end

				Fs.write(
					colors_dir .. colorscheme_name .. '.lua',
					COLORSCHEME_FMT:format(palette_name, colorscheme_name, groups_name),
					WRITE_OPTIONS
				)
			end)

			::continue::
		end
	end
end

do
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
			conditional = ${@conditional.fg | Conditional.fg},
			constant = ${@constant.fg | Constant.fg},
			constant_builtin = ${@constant.builtin.fg},
			constructor = ${@constructor.fg},
			decorator = ${@decorator.fg | @lsp.type.decorator.fg},
			define = ${@define.fg | Define.fg},
			diff_add = ${GitSignsAdd.fg | GitGutterAdd.fg | DiffAdd.bg},
			diff_change = ${GitSignsText.fg | GitGutterChange.fg | DiffText.bg},
			diff_delete = ${GitSignsDelete.fg | GitGutterDelete.fg | DiffDelete.bg},
			enum = ${@enum.fg | @lsp.type.enum.fg},
			error = ${DiagnosticUnderlineError.sp | @error.fg | ErrorMsg.fg | @text.danger.fg},
			event = ${@event.fg},
			field = ${@field.fg},
			field_enum = ${@enumMember.fg | @lsp.type.enumMember.fg},
			float = ${@float.fg | Float.fg},
			fold = ${Folded.bg | Folded.fg},
			func = ${@function.fg | @function.call.fg | Function.fg},
			func_builtin = ${@function.builtin.fg},
			hint = ${DiagnosticUnderlineHint.sp | SpellCap.sp},
			identifier = ${Identifier.fg},
			include = ${@include.fg | Include.fg},
			info = ${DiagnosticUnderlineInfo.sp | @text.note.fg},
			interface = ${@interface.fg | @lsp.type.interface.fg},
			keyword = ${@keyword.fg | Keyword.fg},
			keyword_coroutine = ${@keyword.coroutine.fg},
			keyword_function = ${@keyword.function.fg},
			keyword_operator = ${@keyword.operator.fg},
			keyword_return = ${@keyword.return.fg},
			label = ${@label.fg | Label.fg},
			loop = ${@repeat.fg | Repeat.fg},
			macro = ${@macro.fg | Macro.fg},
			message = ${ModeMsg.fg | Question.fg},
			method = ${@method.fg | @method.call.fg},
			namespace = ${@namespace.fg},
			number = ${@number.fg | Number.fg},
			ok = ${DiagnosticUnderlineOk.sp | SpellRare.sp},
			operator = ${@operator.fg | Operator.fg},
			parameter = ${@parameter.fg},
			preproc = ${@preproc.fg | PreProc.fg},
			preproc_conditional = ${PreCondit.fg},
			property = ${@property.fg | Identifier.fg},
			punctuation = ${@punctuation.fg | Delimiter.fg},
			punctuation_bracket = ${@punctuation.bracket.fg},
			punctuation_delimiter = ${@punctuation.delimiter.fg},
			punctuation_special = ${@punctuation.special.fg},
			search = ${Search.sp | Search.bg | Search.fg},
			select = ${Visual.bg | PmenuSel.bg},
			special = ${Special.fg},
			statement = ${Statement.fg},
			storage = ${@storageclass.fg | StorageClass.fg},
			string = ${@string.fg | String.fg},
			string_escape = ${@string.escape.fg},
			string_regex = ${@string.regex.fg},
			string_special = ${@string.special.fg},
			structure = ${@structure.fg | Structure.fg},
			syntax_error = ${@error.bg | @error.fg | Error.bg | Error.fg},
			tag = ${@tag.fg},
			tag_attribute = ${@tag.attribute.fg},
			tag_delimiter = ${@tag.delimiter.fg},
			text = ${Normal.fg},
			text_contrast_bg_high = ${@punctuation.fg | Delimiter.fg},
			text_contrast_bg_low = ${@comment.fg | Comment.fg},
			text_literal = ${@text.literal.fg},
			text_reference = ${@text.reference.fg},
			throw = ${@exception.fg | Exception.fg},
			todo = ${Todo.bg | Todo.fg | @text.todo.bg | @text.todo.fg},
			type = ${@type.fg | Type.fg},
			type_builtin = ${@type.builtin.fg},
			type_parameter = ${@typeParameter.fg | @lsp.type.typeParameter.fg},
			uri = ${Underlined.fg | @text.uri.fg},
			variable = ${@variable.fg},
			variable_builtin = ${@variable.builtin.fg},
			warning = ${DiagnosticUnderlineWarn.sp | WarningMsg.fg | @text.warning.fg},
		},
	}]]

	--- Create a wezterm theme out of the `palette`
	--- @async
	--- @param name string the name of an *installed* Neovim colorscheme. Can be written in either Lua or VimScript
	--- @param opts? highlite.Fmt.string.opts
	--- @return {[highlite.bg]: {palette: highlite.color.palette, terminal: highlite.color.palette.terminal}}
	function Import.nvim(name, opts)
		-- NOTE: we force this plugin to load colorschemes with all groups enabled
		if name:find '^highlite' then require('highlite').setup() end

		opts = vim.tbl_extend('force', opts or {}, {default = 'nil', loadstring_compat = true})

		local previous_bg = vim.api.nvim_get_option 'background' --- @type highlite.bg
		local previous_colorscheme = vim.api.nvim_get_var 'colors_name'

		local by_bg = {}
		local next_bg = previous_bg == 'dark' and 'light' or 'dark' --- @type highlite.bg

		--- @param bg highlite.bg
		local function import_bg(bg)
			local load, err = loadstring(Fmt.string(FMT, opts))
			if load == nil or err then
				error(
					'Could not load formatted string for colorscheme ' .. name ..
					' with options ' .. vim.inspect(opts, {indent = '', newline = ' '}) ..
					(err == nil and '' or ': ' .. err)
				)
			end

			by_bg[bg] = load()
		end

		Util.switch_colorscheme(name)

		vim.api.nvim_set_option('background', next_bg)
		import_bg(next_bg)
		vim.api.nvim_set_option('background', previous_bg)
		import_bg(previous_bg)

		Util.switch_colorscheme(previous_colorscheme)

		for bg, tbl in pairs(by_bg) do
			Palette.derive(bg, tbl.palette)
			-- NOTE: deriving doesn't resolve all color values immediately; it only happens when an index is missing.
			--       we derive the default groups so that all of the color values will have been indexed at least once,
			--       thus forcing the derive.
			default_groups_from_palette(tbl.palette, {plugins = true, syntax = true})
		end

		return by_bg
	end
end

return Import
