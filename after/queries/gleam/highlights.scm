;; extends

; identifier

(binary_expression
	operator: "|>"
	right: (field_access field: (label) @function)
)

(constant name: (identifier) @constant)

; modifiers

(attribute
	.
	"@" @punctuation.special
	.
	name: (identifier) @attribute
)

; operator

(binary_expression operator: "<>" @operator)
(case_clause_patterns "|" @operator)
(discard) @variable.builtin

(use
	"use" @keyword.coroutine
	"<-" @operator
)

; punctuation

(module "/" @punctuation.delimiter)
