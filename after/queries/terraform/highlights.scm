;; extends

; identifiers

(config_file
(body
(block
	.
	(identifier) @_block (#any-of? @_block "output")
	.
	[
		(identifier) @variable.member
		(string_lit (template_literal) @variable.member)
	]
	.
)))

(config_file
(body
(block
	.
	(identifier) @_block (#any-of? @_block "variable")
	.
	[
		(identifier) @variable.parameter
		(string_lit (template_literal) @variable.parameter)
	]
	.
)))

(config_file
(body
(block
	.
	(identifier) @_block (#not-any-of? @_block "output" "variable")
	.
	[
		(identifier) @type
		(string_lit (template_literal) @type)
	]
	.
	([
		(identifier) @structure
		(string_lit (template_literal) @structure)
	])?
)))

[
	(null_lit)
] @constant.builtin

; operators

("=" @operator
	(#has-parent? @operator attribute object_elem)
)
