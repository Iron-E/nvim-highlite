;; extends

; identifiers

(block
	.
	(identifier) @_block (#any-of? @_block "dynamic" "module" "resource")
	(body
		(attribute
			(identifier) @keyword.repeat
			(#any-of? @keyword.repeat "count" "for_each")
		)
	)
)

(body
(block
	.
	(identifier) @keyword.modifier (#eq? @keyword.modifier "dynamic")
	.
	(string_lit (template_literal) @type)
	.
	(block_start)
))

(body
(block
	.
	(identifier) @_block (#eq? @_block "dynamic")
	(body (block (identifier) @keyword.return)) (#eq? @keyword.return "content")
))

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
	(identifier) @_block (#not-any-of? @_block "dynamic" "module")
	.
	(string_lit (template_literal) @variable.member)
	.
	(block_start)
))

(body
(block
	.
	(identifier) @keyword.type (#not-any-of? @keyword.type "dynamic" "module")
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
		"count"
		"data"
		"each"
		"local"
		"path"
		"self"
		"terraform"
		"var"
	)
)

[
	(null_lit)
] @constant.builtin

; punctuation

(conditional [ "?" ":" ] @keyword.conditional.ternary)

("=" @operator
	(#has-parent? @operator attribute object_elem)
)

(for_intro ":" @punctuation.delimiter)

("=>" @punctuation.delimiter)
