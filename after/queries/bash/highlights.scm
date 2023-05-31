;; extends

; interpolation
(command_substitution ["$(" ")"] @punctuation.special)
(expansion ["${" "}"] @punctuation.special)

; variables
(variable_name) @variable
