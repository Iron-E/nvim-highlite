;; extends

; attributes
(attribute_item . "#" @punctuation.bracket)
(inner_attribute_item ["!" "#"] @punctuation.bracket)

(attribute
	[
		(identifier) @preproc.conditional
		(scoped_identifier name: (identifier) @preproc.conditional)
	]
	(#any-of? @preproc.conditional "cfg" "cfg_attr")
)

(attribute
	[
		(identifier) @preproc
		(scoped_identifier name: (identifier) @preproc)
	]
	(#not-any-of? @preproc "cfg" "cfg_attr")
)

(token_tree (identifier) @keyword.operator
	(#any-of? @keyword.operator "all" "any" "not")
	(#has-ancestor? @keyword.operator attribute) ; NOTE: comes from `nvim-treesitter`
)

; closure delimiters
(closure_parameters . ("|" @function) ("|" @function) .)

; de/ref characters
(reference_expression . "&" @storageclass)
(reference_pattern . "&" @storageclass)
(reference_type . "&" @storageclass)
(self_parameter . "&" @storageclass)
(unary_expression . "*" @storageclass)

((ERROR) @storageclass
	(#eq? @storageclass "~")
	(#offset-from-start! @storageclass 0 0 0 1)
)

; enum variants
(call_expression
	function: (scoped_identifier
		name: (identifier) @type (#lua-match? @type "^%u")
	)
)

(enum_variant name: (identifier) @type)
((identifier) @type.builtin
	(#any-of? @type.builtin "Some" "None" "Ok" "Err")
)

; HRTB closures
(ERROR "for" "<" @punctuation.bracket (lifetime) ">" @punctuation.bracket)

; macros
(macro_invocation
	macro: (identifier) @_id @debug (#contains? @_id "assert" "dbg" "debug")
	"!" @debug
	(#set! "priority" 101)
)

(macro_invocation
	macro: (identifier) @_id @include (#contains? @_id "include")
	"!" @include
	(#set! "priority" 101)
)

; patterns
(match_pattern "_" @variable.builtin)

; raw identifiers
(
	[
		(field_identifier) @punctuation.special
		(identifier) @punctuation.special
	]
	(#lua-match? @punctuation.special "^r#")
	(#offset-from-start! @punctuation.special 0 0 0 2)
)

((raw_string_literal) @punctuation.special
	(#lua-match? @punctuation.special "^r#")
	(#offset-from-start! @punctuation.special 0 0 0 2)
)

((raw_string_literal) @punctuation.special
	(#lua-match? @punctuation.special "^r#")
	(#offset-from-end! @punctuation.special 0 -1 0 0)
)

((raw_string_literal) @punctuation.special
	(#lua-match? @punctuation.special "^r##")
	(#offset-from-start! @punctuation.special 0 0 0 3)
)

((raw_string_literal) @punctuation.special
	(#lua-match? @punctuation.special "^r##")
	(#offset-from-end! @punctuation.special 0 -2 0 0)
)

((raw_string_literal) @punctuation.special
	(#lua-match? @punctuation.special "^r###")
	(#offset-from-start! @punctuation.special 0 0 0 4)
)

((raw_string_literal) @punctuation.special
	(#lua-match? @punctuation.special "^r###")
	(#offset-from-end! @punctuation.special 0 -3 0 0)
)

; `try!`
(try_expression ("?" @exception))

; unsafe
"unsafe" @exception
