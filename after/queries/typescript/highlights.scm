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
	"static"
] @keyword.storage

[
	"private"
	"protected"
	"public"
] @keyword

(generator_function_declaration "*" @keyword.storage)
(method_definition (accessibility_modifier) "async"? . "*" @keyword.storage)

; operators

(intersection_type "&" @operator)
(union_type "|" @operator)

; types

(this_type) @type.definition
