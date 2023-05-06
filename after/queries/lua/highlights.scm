;; extends

; builtins
(vararg_expression) @variable.builtin

; debug
((identifier) @debug (#eq? @debug "debug"))

; repeat
"in" @repeat

; require `@namespace`s
(function_call
	name: (identifier) @_fn (#eq? @_fn "require")
	arguments: (arguments (string "string_content" @namespace))
)
