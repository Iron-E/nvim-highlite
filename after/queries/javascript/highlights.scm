;; extends

; modifiers
(lexical_declaration "const" @storageclass)

; namespaces
(call_expression
	function: (identifier) @_function (#eq? @_function "require")
	arguments: (arguments (string (string_fragment) @namespace))
)
