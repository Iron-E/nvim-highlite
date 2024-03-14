;; extends

; punctuation

(binding "=" @operator)

(function_expression [
	"@" @operator
	":" @punctuation.delimiter
])

(ellipses) @variable.builtin

(has_attr_expression "?" @operator)
