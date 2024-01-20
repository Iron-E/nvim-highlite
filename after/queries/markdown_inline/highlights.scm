;; extends

; punctuation
(inline_link ["[" "]" "(" ")"] @punctuation.bracket)
(image
	"!" @punctuation.special
	["[" "]" "(" ")"] @punctuation.bracket
)

[
	(code_span_delimiter)
	(emphasis_delimiter)
] @markup.environment
