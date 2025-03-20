;; extends

; keywords

"function" @keyword.function
(forspec "in" @repeat)

(
	(id) @module.builtin
	(#eq? @module.builtin "std")
)

; semantics
(
	(string (string_content) @string.special.path) @_str
	(#has-parent? @_str import importstr)
)

; symbols
"=" @operator
(string . "@" @punctuation.special)
