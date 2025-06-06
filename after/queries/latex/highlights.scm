;; extends

; environment
(inline_formula "$" @markup.environment (#set! conceal_lines ""))
(displayed_equation "$$" @markup.environment (#set! conceal_lines ""))

; markup

(text_mode
	content: (curly_group
		(text word: (word) @markup)
	)
)
