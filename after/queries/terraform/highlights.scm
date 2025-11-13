;; extends

; identifiers

(attribute
	(identifier) @keyword.repeat
	(#eq? @keyword.repeat "for_each")
)

(config_file
(body
(block
	.
	(identifier) @keyword.import (#eq? @keyword.import "module")
	.
	(string_lit (template_literal) @module)
	.
	(block_start)
)))

(body
(block
	.
	(identifier) @_block (#not-any-of? @_block "module")
	.
	(string_lit (template_literal) @variable.member)
	.
	(block_start)
))

(body
(block
	.
	(identifier) @keyword.type (#not-any-of? @keyword.type "module")
	.
	(string_lit (template_literal) @type)
	.
	(string_lit (template_literal) @variable.member)+
	.
	(block_start)
))

(expression
	.
	(variable_expr (identifier) @type)
	.
	(get_attr (identifier))
	(#not-any-of? @type
		"count"
		"data"
		"each"
		"local"
		"module"
		"path"
		"self"
		"terraform"
		"var"
	)
)

(expression
	.
	(variable_expr (identifier) @type)
	.
	(get_attr (identifier) @variable.member)
	.
	(get_attr (identifier))
	(#not-any-of? @type
		"count"
		"data"
		"each"
		"local"
		"module"
		"path"
		"self"
		"terraform"
		"var"
	)
)

(expression
	.
	(variable_expr (identifier) @_ident)
	.
	(get_attr (identifier) @module)
	(#eq? @_ident "module")
)

(expression
	.
	(variable_expr (identifier) @variable.builtin)
	.
	(get_attr (identifier) @variable.member)
	(#any-of? @variable.builtin
		"path"
		"terraform"
	)
)

[
	(null_lit)
] @constant.builtin

; operators

("=" @operator
	(#has-parent? @operator attribute object_elem)
)

("=>" @punctuation.delimiter)
