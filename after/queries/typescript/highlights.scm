;; extends

; namespaces
(call_expression
	function: (identifier) @_function (#eq? @_function "require")
	arguments: (arguments (string (string_fragment) @namespace))
)

(internal_module name: (identifier) @namespace (#set! "priority" 126))

; storageclass
"const" @storageclass
