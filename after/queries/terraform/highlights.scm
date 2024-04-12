;; extends

; block syntax

(config_file
(body
(block
	.
	(identifier)
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

; operators

("=" @operator
	(#has-parent? @operator attribute object_elem)
)
