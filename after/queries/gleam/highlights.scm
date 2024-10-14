;; extends

; punctuation

(module "/" @punctuation.delimiter)

; operator

(case_clause_patterns "|" @operator)
(discard) @variable.builtin
(use "<-" @operator)
