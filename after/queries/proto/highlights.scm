;; extends

; keywords

[
  "oneof"
] @keyword.conditional

(syntax "syntax" @variable.builtin)

(ERROR
  .
  (ERROR) @variable.builtin
  .
  "="
  .
  (
    "\"" @string.special
    .
    (decimal_lit)? @string.special
    .
    "\"" @string.special
  )?
  .

  (#eq? @variable.builtin "edition")
)

(import
  path: (string) @module
  (#offset! @module 0 1 0 -1)
)

(option
  "option" @keyword.directive
  (identifier) @variable
  (#set! "priority" 126)
)

(rpc "stream" @keyword.coroutine)

; punctuation

(full_ident
  [
    (identifier) @module
    "." @punctuation.delimiter
  ]
)

(message_or_enum_type
  "." @punctuation.delimiter
  (#set! "priority" 126)
)

; types

(message_or_enum_type
  (identifier) @module
  (#lua-match? @module "^[a-z]")
  (#set! "priority" 126)
)

(message_or_enum_type
  (identifier) @structure
  (#lua-match? @structure "^[A-Z]")
)

(
  (type
    .
    _ @_type
    (#not-kind-eq? @_type "message_or_enum_type")
  ) @type.builtin
  (#set! "priority" 126)
)

(rpc_name (identifier) @function)
