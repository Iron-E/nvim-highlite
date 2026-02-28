;; extends

; identifiers

(
  (variable_expr (identifier) @variable.builtin)
  .
  (get_attr (identifier) @variable.member)
  .
  (get_attr (identifier) @variable.member)*
)


[
  (null_lit)
] @constant.builtin

; punctuation

(conditional [ "?" ":" ] @keyword.conditional.ternary)

("=" @operator
  (#has-parent? @operator attribute object_elem)
)

(for_intro ":" @punctuation.delimiter)

("=>" @punctuation.delimiter)

(splat
  (full_splat "[*]" @character.special)
  (#offset! @character.special 0 1 0 -1)
)

(splat
  (attr_splat ".*" @character.special)
  (#offset! @character.special 0 1 0 0)
)
