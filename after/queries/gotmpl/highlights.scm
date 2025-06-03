;; extends

; special

(variable
	"$" @punctuation.special
	(#set! "priority" 110)
)

(function_call
	function: (identifier) @operator
	(#any-of? @operator "and" "eq" "gt" "lt" "ne" "not" "or")
	(#set! "priority" 111)
)

(function_call
	function: (identifier) @keyword.import
	(#eq? @keyword.import "include")
	(#set! "priority" 111)
)

(
	[
		"-}}"
		"{{"
		"{{-"
		"}}"
	] @punctuation.special
	(#set! "priority" 111)
)

(variable
	"$" @constant.builtin
	(#set! "priority" 111)
)
