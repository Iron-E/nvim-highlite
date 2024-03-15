;; extends

; comments
(note) @comment.note

; markup
(codespan "`" @markup.environment)
(argument ["{" "}"] @markup.environment (#set! conceal ""))

; punctuation
(optionlink "'" @punctuation.bracket (#set! conceal ""))
(optionlink text: (word) @variable.builtin)

(taglink "|" @punctuation.bracket)

; special keys
(keycode) @string.keycode
