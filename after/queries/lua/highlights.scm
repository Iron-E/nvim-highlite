;; extends

; builtins
(vararg_expression) @variable.builtin

; debug / error
((identifier) @debug (#eq? @debug "debug") (#set! "priority" 128))
((identifier) @exception (#eq? @exception "error") (#set! "priority" 128))

; repeat
"in" @repeat

; strings
(function_call
	name: (identifier) @_fn (#eq? @_fn "require")
	arguments: (arguments (string
		content: (string_content) @namespace
	))
)

(string_content (escape_sequence) @string.escape)
