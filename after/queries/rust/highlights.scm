;; extends

; attributes
(attribute_item . "#" @punctuation.bracket)
(attribute (identifier) @preproc (#not-any-of? @preproc "cfg" "cfg_attr"))
(attribute (identifier) @preproc.conditional (#any-of? @preproc.conditional "cfg" "cfg_attr"))
(inner_attribute_item ["!" "#"] @punctuation.bracket)
(token_tree (identifier) @keyword.operator
	(#any-of? @keyword.operator "all" "any" "not")
	(#has-ancestor? @keyword.operator attribute) ; NOTE: comes from `nvim-treesitter`
)

; captures
(captured_pattern "@" @punctuation.special)

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
(enum_variant name: (identifier) @constant !body)
(enum_variant
  name: (identifier) @type
  body: [(field_declaration_list) (ordered_field_declaration_list)]
)

; HRTB closures
(ERROR "for" "<" @punctuation.bracket (lifetime) ">" @punctuation.bracket)

; includes
((macro_invocation macro: (identifier) @_id (#eq? @_id "include")) @include
	(#offset-from-start! @include 0 0 0 8)
	(#set! "priority" 101)
)

((macro_invocation macro: (identifier) @_id (#eq? @_id "include_str")) @include
	(#offset-from-start! @include 0 0 0 12)
	(#set! "priority" 101)
)

; raw identifiers
((field_identifier) @punctuation.special
	(#lua-match? @punctuation.special "^r#")
	(#offset-from-start! @punctuation.special 0 0 0 2)
)

((identifier) @punctuation.special
	(#lua-match? @punctuation.special "^r#")
	(#offset-from-start! @punctuation.special 0 0 0 2)
)

; trait bounds
(removed_trait_bound "?" @punctuation.special)

; `try!`
(try_expression ("?" @exception))
