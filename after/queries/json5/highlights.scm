;; extends

; punctuation

[
  "{"
  "["
  "]"
  "}"
] @punctuation.bracket

[
  ":"
  ","
] @punctuation.delimiter


; identifiers

(member
  name: (string) @variable.member
  (#not-eq? @variable.member "")
  (#offset! @variable.member 0 1 0 -1)
  (#set! "priority" 101)
)

; keywords

(null) @constant.builtin
