;; extends

; namespaces

(call_expression
	function: (identifier) @_function (#eq? @_function "require")
	arguments: (arguments (string (string_fragment) @module))
)

(export_statement source: (string (string_fragment) @module))
(import_statement source: (string (string_fragment) @module))
(internal_module name: (identifier) @module (#set! "priority" 126))

; modifiers

[
	"const"
	"readonly"
] @keyword.modifier.mutability

[
	"static"
] @keyword.modifier.lifetime

("*" @attribute
	(#has-parent? @attribute generator_function_declaration method_definition)
)

; operators

(intersection_type "&" @operator)
(union_type "|" @operator)

; types

(this_type) @type.definition
