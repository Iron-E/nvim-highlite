;; extends

; closure delimiters
(closure_parameters . ("|" @function) ("|" @function) .)

; enum variants
(scoped_identifier
	name: (identifier) @type (#lua-match? @type "^%u%l")
)

(scoped_type_identifier
	name: (type_identifier) @structure (#lua-match? @structure "^%u%l")
)

(enum_variant name: (identifier) @type)
((identifier) @type.builtin
	(#any-of? @type.builtin "Some" "None" "Ok" "Err")
)

; HRTB closures
(ERROR "for" "<" @punctuation.bracket (lifetime) ">" @punctuation.bracket)

; macros
(macro_invocation
	macro: (identifier) @_id @keyword.debug (#contains? @_id "dbg" "debug")
	"!" @keyword.debug
	(#set! "priority" 101)
)

(macro_invocation
	macro: (identifier) @_id @keyword.import (#contains? @_id "include")
	"!" @keyword.import
	(#set! "priority" 101)
)

(macro_invocation
	macro: (identifier) @_id @keyword.exception (#contains? @_id
		"assert"
		"assert_eq"
		"assert_ne"
		"panic"
		"todo"
		"unimplemented"
		"unreachable"
	)
	"!" @keyword.exception
	(#set! "priority" 101)
)

(token_binding_pattern
	type: (fragment_specifier) @type.builtin
)

(token_repetition_pattern ["?" "*" "+" ] @keyword.repeat)

; patterns
(match_pattern "_" @variable.builtin)

;; preprocs
(attribute
	[
		(identifier) @keyword.directive.conditional
		(scoped_identifier name: (identifier) @keyword.directive.conditional)
	]
	(#any-of? @keyword.directive.conditional "cfg" "cfg_attr")
)

(attribute
	[
		(identifier) @keyword.directive
		(scoped_identifier name: (identifier) @keyword.directive)
	]
	(#not-any-of? @keyword.directive "cfg" "cfg_attr")
)

(token_tree (identifier) @keyword.operator
	(#any-of? @keyword.operator "all" "any" "not")
	(#has-ancestor? @keyword.operator attribute) ; NOTE: comes from `nvim-treesitter`
)

; raw identifiers
(
	[
		(field_identifier) @punctuation.special
		(identifier) @punctuation.special
	]
	(#lua-match? @punctuation.special "^r#")
	(#offset-from! "start" @punctuation.special 0 0 0 2)
	(#set! priority 128)
)

((raw_string_literal) @punctuation.special
	(#lua-match? @punctuation.special "^r\"")
	(#offset-from! "start" @punctuation.special 0 0 0 1)
)

((raw_string_literal) @punctuation.special
	(#lua-match? @punctuation.special "^r#\"")
	(#offset-from! "start" @punctuation.special 0 0 0 2)
)

((raw_string_literal) @punctuation.special
	(#lua-match? @punctuation.special "^r#\"")
	(#offset-from! "end" @punctuation.special 0 -1 0 0)
)

((raw_string_literal) @punctuation.special
	(#lua-match? @punctuation.special "^r##\"")
	(#offset-from! "start" @punctuation.special 0 0 0 3)
)

((raw_string_literal) @punctuation.special
	(#lua-match? @punctuation.special "^r##\"")
	(#offset-from! "end" @punctuation.special 0 -2 0 0)
)

((raw_string_literal) @punctuation.special
	(#lua-match? @punctuation.special "^r###\"")
	(#offset-from! "start" @punctuation.special 0 0 0 4)
)

((raw_string_literal) @punctuation.special
	(#lua-match? @punctuation.special "^r###\"")
	(#offset-from! "end" @punctuation.special 0 -3 0 0)
)

; storageclass
(mutable_specifier) @keyword.modifier.mutability

("&" @type.pointer (#has-parent? @type.pointer reference_pattern reference_type self_parameter))
"ref" @type.pointer

[
	"move"
	"static"
] @keyword.modifier.lifetime

((ERROR) @keyword.modifier.lifetime
	(#eq? @keyword.modifier.lifetime "~")
	(#offset-from! "start" @keyword.modifier.lifetime 0 0 0 1)
)

; `try!`
(try_expression ("?" @keyword.exception))

; unsafe
"unsafe" @keyword.exception
