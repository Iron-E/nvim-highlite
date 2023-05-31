;; extends

; interpolation
(command_substitution ["$(" ")"] @punctuation.special)
(expansion ["${" "}"] @punctuation.special)

; repeat
(for_statement "in" @repeat)

; variables
(variable_name) @variable
