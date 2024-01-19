;; extends

; events
(au_event) @event

; keywords
((augroup_name) @keyword (#lua-match? @keyword "[Ee][Nn][Dd]"))
[
	"<buffer>"
	"<expr>"
	"<nowait>"
	"<script>"
	"<silent>"
	"<unique>"
] @variable.parameter

; namespaces
((scope) @punctuation.delimiter (#offset-from! "end" @punctuation.delimiter 0 -1 0 0))

; normal commands
(commands) @string

; operators
(execute_statement
	(call_expression
		function: (field_expression "." @operator)
	)
)

; options
((set_value) @number (#lua-match? @number "^-?%d+$"))
((set_value) @string (#not-lua-match? @string "^-?%d+$"))

(option "&" @punctuation.special)

; special keys
((keycode) @string.keycode
	(#set! "priority" 101)
)

; wildcards
(file) @character.special
(last_line "$" @character.special)
