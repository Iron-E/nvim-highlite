;; extends

; builtins
(vararg_expression) @variable.builtin

; debug / error
((identifier) @keyword.debug (#eq? @keyword.debug "debug") (#set! "priority" 128))
((identifier) @keyword.exception (#eq? @keyword.exception "error") (#set! "priority" 128))

; repeat
"in" @keyword.repeat

; strings
(function_call
	name: (identifier) @_fn (#eq? @_fn "require")
	arguments: (arguments (string
		content: (string_content) @module
	))
)

(string_content (escape_sequence) @string.escape)
