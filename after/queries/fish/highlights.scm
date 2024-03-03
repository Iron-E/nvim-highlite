;; extends

; builtins

(command
	name: (word) @function.builtin
	(#any-of? @function.builtin "abbr" "path")
)

(for_statement "in" @keyword.repeat)

; punctuation

(glob) @character.special

(double_quote_string (command_substitution ["$" "(" ")"] @punctuation.special))
(variable_expansion "$" @punctuation.special)
