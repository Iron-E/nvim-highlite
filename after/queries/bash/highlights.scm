;; extends

; interpolation
(command_substitution "`" @punctuation.special)

(command_substitution "$(" @punctuation.special (#offset! @punctuation.special 0 0 0 -1))
(expansion "${" @punctuation.bracket (#offset! @punctuation.bracket 0 1 0 0))
(expansion "${" @punctuation.special (#offset! @punctuation.special 0 0 0 -1))
(expansion "}" @punctuation.bracket)

; repeat
(for_statement "in" @keyword.repeat)
