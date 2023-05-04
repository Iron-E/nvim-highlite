;; extends

; debug
((identifier) @debug (#eq? @debug "debug"))

; require `@namespace`s
(function_call
	name: (identifier) @_fn (#eq? @_fn "require")
	arguments: (arguments (string "string_content" @namespace))
)
