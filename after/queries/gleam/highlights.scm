;; extends

; identifier

(binary_expression
	operator: "|>"
	right: (field_access field: (label) @function)
)

; modifiers

(attribute
	.
	"@" @punctuation.special
	.
	name: (identifier) @attribute
)

; operator

(case_clause_patterns "|" @operator)
(discard) @variable.builtin
(use "<-" @operator)

; punctuation

(module "/" @punctuation.delimiter)
