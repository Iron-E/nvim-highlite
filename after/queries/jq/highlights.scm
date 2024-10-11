;; extends

; punctuation

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

(objectval . "." @variable.builtin .) ; {foo: <.>}
(objectval
	.
	term_with_object_access: (index . "." @variable.builtin)
	term_with_object_access: (index . "." @punctuation.delimiter)
)

(string
	"\\(" @punctuation.special
	.
	(query)
	.
	")" @punctuation.special
)
