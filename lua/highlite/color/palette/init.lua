local Color = require 'highlite.color' --- @type highlite.Color
local Table = require 'highlite.table' --- @type highlite.Table

--- @alias highlite.bg 'dark'|'light'

--- @class highlite.color.palette: highlite.colors
--- @field annotation highlite.color
--- @field attribute highlite.color
--- @field bg highlite.color the background color
--- @field bg_contrast_high highlite.color an accent to the `bg` color which contrasts
--- @field bg_contrast_low highlite.color an accent to the `bg` color which barely contrasts
--- @field boolean highlite.color `true` and `false`
--- @field buffer_active highlite.color the underline of an active buffer
--- @field buffer_alternate highlite.color the underline of the alternate buffer
--- @field buffer_current highlite.color the underline of the current buffer
--- @field character highlite.color character literals (e.g. `'a'`)
--- @field character_special highlite.color special characters e.g. wildcards
--- @field class highlite.color data with behavior
--- @field comment highlite.color normal comments
--- @field comment_documentation highlite.color documentation comments
--- @field comment_special highlite.color special tokens in a comment
--- @field conditional highlite.color e.g. `if`, `match`, `switch`
--- @field constant highlite.color constant values
--- @field constant_builtin highlite.color built-in constant values
--- @field constructor highlite.color invoked by `new`
--- @field decorator highlite.color
--- @field define highlite.color e.g. `#define` in C
--- @field diff_add highlite.color added text
--- @field diff_change highlite.color changed text, also applies to modified buffers in the tabline
--- @field diff_delete highlite.color removed text
--- @field enum highlite.color an enumeration
--- @field error highlite.color diagnostic errors
--- @field event highlite.color events e.g. `public event FooEventHandler FooEvent` in C#
--- @field field highlite.color a member of a class/struct which is accessed directly
--- @field field_enum highlite.color a variant of an enum e.g. `Ok` in Rust
--- @field float highlite.color floating point numbers
--- @field fold highlite.color the background of `&foldtext`
--- @field func highlite.color functions, e.g. `print('a')`
--- @field func_builtin highlite.color builtin function
--- @field hint highlite.color diagnostic hints
--- @field identifier highlite.color misc. identifier
--- @field include highlite.color e.g. `#include` in C
--- @field info highlite.color diagnostic info
--- @field interface highlite.color e.g. `interface Foo`
--- @field keyword highlite.color keywords, e.g. `local` in Lua
--- @field keyword_coroutine highlite.color e.g. `await`
--- @field keyword_function highlite.color e.g. `fn` in Rust, `def` in Python
--- @field keyword_operator highlite.color e.g. `and` in Lua
--- @field keyword_return highlite.color e.g. `return`, `yield`
--- @field label highlite.color switch cases, loop labels (e.g. `'outer for x in y { break 'outer }` in Rust)
--- @field loop highlite.color e.g. `loop`, `for`, `while`
--- @field macro highlite.color e.g. `println!` in Rust
--- @field message highlite.color Builtin Vim messages
--- @field method highlite.color function of a class
--- @field namespace highlite.color e.g. `foo::bar` in Rust/C++
--- @field number highlite.color number literals (e.g `9`)
--- @field ok highlite.color positive reinforcement from LSP or Git
--- @field operator highlite.color e.g. `+`, `-`, `&&`
--- @field parameter highlite.color a function parameter
--- @field preproc highlite.color pre-processor commands (e.g. `#[derive]` in Rust)
--- @field preproc_conditional highlite.color pre-processor conditionals (e.g. `#[cfg]` in Rust)
--- @field property highlite.color a member of a class or structure which is transparently a function
--- @field punctuation highlite.color misc. delimiters
--- @field punctuation_bracket highlite.color balanced punctuation, e.g. `[]`, `""`, `()`
--- @field punctuation_delimiter highlite.color single punctuation, e.g. `,`, `;`
--- @field punctuation_special highlite.color special punctuation, e.g. `{}` in a format string
--- @field search highlite.color Doing `:/` or `:s/`
--- @field select highlite.color selected text, e.g. in visual mode or selecting LSP completions
--- @field special highlite.color unclassified special symbols in a language
--- @field statement highlite.color programming language statements which do not fall into another category
--- @field storage highlite.color pointer symbols (e.g. `&foo`)
--- @field string highlite.color a misc. string
--- @field string_escape highlite.color escaped characters in a string
--- @field string_regex highlite.color regular expressions
--- @field string_special highlite.color special strings (e.g. dates)
--- @field structure highlite.color plain-old data
--- @field syntax_error highlite.color non-diagnostic errors; sometimes shown in the actual highlighting of the code you write
--- @field tag highlite.color XML/HTML tags
--- @field tag_attribute highlite.color XML/HTML tag attributes
--- @field tag_delimiter highlite.color `<`/`>` in XML/HTML tags
--- @field text highlite.color plaintext
--- @field text_contrast_bg_high highlite.color an accent to the `text` color which contrasts
--- @field text_contrast_bg_low highlite.color an accent to the `text` color which barely contrasts
--- @field text_literal highlite.color literal text
--- @field text_reference highlite.color references to variables in text
--- @field throw highlite.color a keyword which triggers or receives errors (e.g. `throw MyError`)
--- @field todo highlite.color `TODO` comments
--- @field type highlite.color type names e.g. `int`, `String`
--- @field type_builtin highlite.color a type from the standard library
--- @field type_parameter highlite.color generic type
--- @field uri highlite.color links (HTTP, tags, match paren, etc).
--- @field variable highlite.color a variable
--- @field variable_builtin highlite.color a variable from the language, e.g. `self`
--- @field warning highlite.color diagnostic warnings

--- A map of palette colors to an alternate color where they can be found
--- The values with no alternate are:
---
--- * `bg`
--- * `error`
--- * `ok`
--- * `statement`
--- * `storage`
--- * `text`
local PALETTE_ALTS =
{
	annotation = 'attribute',
	attribute = 'preproc',
	bg_contrast_high = 'bg',
	bg_contrast_low = 'bg',
	boolean = 'constant',
	buffer_active = 'text_contrast_bg_high',
	buffer_alternate = 'search',
	buffer_current = 'select',
	character = 'string',
	character_special = 'special',
	class = 'structure',
	comment = 'text_contrast_bg_low',
	comment_documentation = 'comment',
	conditional = 'keyword',
	constant = 'storage',
	constant_builtin = 'special',
	constructor = 'type',
	decorator = 'attribute',
	define = 'preproc',
	diff_add = 'ok',
	diff_change = 'number',
	diff_delete = 'error',
	enum = 'structure',
	event = 'loop',
	field = 'property',
	field_enum = 'constant',
	float = 'number',
	fold = 'func',
	func = 'statement',
	func_builtin = 'special',
	hint = 'info',
	identifier = 'text',
	include = 'preproc',
	info = 'warning',
	interface = 'type',
	keyword = 'statement',
	keyword_coroutine = 'keyword',
	keyword_function = 'type_builtin',
	keyword_operator = 'operator',
	keyword_return = 'keyword',
	label = 'special',
	loop = 'conditional',
	macro = 'define',
	message = 'info',
	method = 'func',
	namespace = 'uri',
	number = 'constant',
	operator = 'keyword',
	parameter = 'identifier',
	preproc = 'func',
	preproc_conditional = 'preproc',
	property = 'identifier',
	punctuation = 'text_contrast_bg_high',
	punctuation_bracket = 'punctuation',
	punctuation_delimiter = 'punctuation',
	punctuation_special = 'string_special',
	search = 'select',
	select = 'bg_contrast_low',
	special = 'statement',
	string = 'constant',
	string_escape = 'character',
	string_regex = 'string',
	string_special = 'identifier',
	structure = 'type',
	syntax_error = 'error',
	tag = 'structure',
	tag_attribute = 'field',
	tag_delimiter = 'punctuation_bracket',
	text_contrast_bg_high = 'text',
	text_contrast_bg_low = 'text',
	text_literal = 'statement',
	text_reference = 'uri',
	throw = 'error',
	todo = 'message',
	type = 'keyword',
	type_builtin = 'type',
	type_parameter = 'type',
	uri = 'text',
	variable = 'identifier',
	variable_builtin = 'keyword',
	warning = 'error',
}

local DERIVE_METATABLE = {__index = function(self, k)
	local value = rawget(self, k)
	if value == nil then
		local alt = PALETTE_ALTS[k]
		if alt ~= nil then
			value = self[alt]
			rawset(self, k, value) -- PERF: cache resolved value so that next time we index `k` it can return right away
		end
	end

	return value
end}

--- Set `color` to `alt` if it is `nil`
--- @package
--- @param self highlite.colors the colors to pool from
--- @param color string the color to derive
--- @param factor integer the amount to saturate the alt by
local function derive_from_saturated_alt(self, color, factor)
	if rawget(self, color) == nil then
		local alt_value = self[PALETTE_ALTS[color]]
		if alt_value ~= nil then
			alt_value = Color.saturate(alt_value, factor)
			rawset(self, color, alt_value)
		end
	end
end

--- @class highlite.color.Palette
--- @field [string] nil|highlite.color.palette.get
local Palette = {}

--- Use what is present in the `colors` to create a cohesive palette.
--- These are the only groups which will not be filled in:
---
--- * bg
--- * error
--- * ok
--- * text
--- * statement
--- * storage
---
--- @see highlite.color.palette
--- @param accent? highlite.bg the background color of Neovim (default `'dark'`)
--- @param colors? highlite.colors the colors to derive
--- @return highlite.color.palette dark palette
function Palette.derive(accent, colors)
	if Table.is_empty(colors) then return require('highlite.color.palette.default')(accent) end
	--- @cast colors -nil

	setmetatable(colors, DERIVE_METATABLE)

	if accent ~= 'light' then
		derive_from_saturated_alt(colors, 'bg_contrast_high', 3)
		derive_from_saturated_alt(colors, 'bg_contrast_low', 2)
		derive_from_saturated_alt(colors, 'text_contrast_bg_high', 1.25)
		derive_from_saturated_alt(colors, 'text_contrast_bg_low', 0.63)
		derive_from_saturated_alt(colors, 'throw', 1.5)
	else
		derive_from_saturated_alt(colors, 'bg_contrast_high', 0.74)
		derive_from_saturated_alt(colors, 'bg_contrast_low', 0.88)
		derive_from_saturated_alt(colors, 'text_contrast_bg_high', 0.5)
		derive_from_saturated_alt(colors, 'text_contrast_bg_low', 2)
		derive_from_saturated_alt(colors, 'throw', 0.8)
	end

	--- @diagnostic disable-next-line:return-type-mismatch we JUST converted the types
	return colors
end

return Palette
