;; extends

; interpolation
(command_substitution ["$(" ")"] @punctuation.special)
(expansion ["${" "}"] @punctuation.special)

; repeat
(for_statement "in" @keyword.repeat)

; variables
(variable_name) @variable
