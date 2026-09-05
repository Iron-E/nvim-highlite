;; extends

; identifiers

((funcname) @function
  (#set! "priority" 99)
)

(import_ (identifier) @module)

; punctuation

(query update: "|=" @operator)

(query . [ ; when at the start of a query
  array_access: "." @variable.builtin ; <.>[].bar
  term: "." @variable.builtin ; (<.>)
  term: (index . "." @variable.builtin) ; (<.>bar.baz | fromdate)
  term_with_object_access: (index . "." @variable.builtin) ; <.>foo.bar
])

(query . _ [ ; when not at the start of a query
  array_access: "." @punctuation.delimiter ; .[]<.>bar
  term: "." @punctuation.delimiter ; (<.>)
  term: (index . "." @punctuation.delimiter) ; (.bar<.>baz | fromdate)
  term_with_object_access: (index . "." @punctuation.delimiter) ; .foo<.>bar
])

(objectval . [ ; when at the start of an object value
  "." @variable.builtin ; {foo: <.>}
  (index . "." @variable.builtin) ; {foo: <.>foo}
  array_access: ("." @variable.builtin) ; {foo: <.>[]}
  term_with_object_access: (index . "." @variable.builtin) ; {foo: <.>bar}
])

(objectval . _ [ ; when not at the start of an object value
  "." @punctuation.delimiter ; {foo: .[]<.>bar}
  (index . "." @punctuation.delimiter) ; {foo: .foo<.>bar}
  array_access: ("." @punctuation.delimiter) ; {foo: .[]<.>[]}
  term_with_object_access: (index . "." @punctuation.delimiter) ; {foo: .foo<.>bar}
])

(string_interp
  "\\(" @punctuation.special
  .
  (query)
  .
  ")" @punctuation.special
)

((variable) @punctuation.special
  (#offset-from! "start" @punctuation.special 0 0 0 1)
)
