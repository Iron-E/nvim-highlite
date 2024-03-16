;; extends

; modifiers

[
	"const"
] @keyword.modifier.mutability

[
	"static"
] @keyword.modifier.lifetime

; namespaces
(call_expression
	function: (identifier) @_function (#eq? @_function "require")
	arguments: (arguments (string (string_fragment) @module))
)
