;; extends

; builtins

(command
	name: (word) @function.builtin
	(#any-of? @function.builtin "abbr" "path")
)

(for_statement "in" @keyword.repeat)

; punctuation

(variable_expansion "$" @punctuation.special)
(glob) @character.special
