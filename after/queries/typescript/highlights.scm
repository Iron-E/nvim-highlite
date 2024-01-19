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
"const" @keyword.storage

[
	"private"
	"protected"
	"public"
] @keyword

; operators
(intersection_type "&" @operator)
(union_type "|" @operator)
