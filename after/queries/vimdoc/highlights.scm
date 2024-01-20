;; extends

; comments
(note) @comment.info

; options
(optionlink
	"'" @conceal (#set! conceal "")
	text: (word) @variable.builtin
)

; parameters
(argument ["{" "}"] @conceal (#set! conceal ""))

; special keys
(keycode) @string.keycode
