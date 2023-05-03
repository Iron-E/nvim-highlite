;; extends

; highlight accessors as operator-keywords
(accessor_declaration _ @keyword.operator)

; highlight arrows as delimiters
"=>" @punctuation.delimiter

; highlight interpolations with the dedicated interpolation group
(interpolation ["{" "}"] @punctuation.special)
