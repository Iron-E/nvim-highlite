;; extends

; comments
(note) @comment.info

; headings
(tag text: (word) @markup.heading.5)

; markup
(codespan "`" @markup.environment)
(argument ["{" "}"] @markup.environment (#set! conceal ""))

; punctuation
(optionlink
	"'" @punctuation.bracket (#set! conceal "")
	text: (word) @variable.builtin
)

(taglink "|" @punctuation.bracket)

; special keys
(keycode) @string.keycode
