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

(
	(variable_expr (identifier) @type) @_expr
	.
	(get_attr (identifier))
	(#has-parent? @_expr expression binary_operation unary_operation)
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

(
	(variable_expr (identifier) @type) @_expr
	.
	(get_attr (identifier) @variable.member)
	.
	(get_attr (identifier))
	(#has-parent? @_expr expression _operation _operation)
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

(
	(variable_expr (identifier) @_ident) @_expr
	.
	(get_attr (identifier) @module)
	(#has-parent? @_expr expression _operation _operation)
	(#eq? @_ident "module")
)

(
	(variable_expr (identifier) @variable.builtin) @_expr
	.
	(get_attr (identifier) @variable.member)
	(#has-parent? @_expr expression _operation _operation)
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
