;; extends

; identifiers
(attribute name: (generic_name (identifier) @attribute))
((identifier) @variable.builtin (#eq? @variable.builtin "_"))
(using_directive (identifier) @module)
(qualified_name (identifier) @module
	(#has-ancestor? @module using_directive) ; NOTE: from nvim-treesitter
)

(generic_name (identifier) @type)

; keywords
(modifier [
	"file" @keyword.modifier
	"static" @keyword.modifier.lifetime
	["const" "readonly"] @keyword.modifier.mutability
])

(lambda_expression [
	((modifier) @keyword.coroutine (#eq? @keyword.coroutine "async"))
	((modifier) @keyword.modifier.lifetime (#eq? @keyword.modifier.lifetime "static"))
])

; operators
(accessor_declaration _ @keyword.operator (#not-eq? @keyword.operator ";"))
(as_expression operator: "as" @operator)
(binary_expression "??" @operator)
(range_expression ".." @operator)

; punctuation
"=>" @punctuation.delimiter
(type_parameter_list . "<" @punctuation.bracket ">" @punctuation.bracket .)

(conditional_access_expression "?" @punctuation.special)
(nullable_type "?" @punctuation.special)

(lambda_expression parameters: (parameter_list
	. "(" @function
	")" @function .
))

; macro
((preproc_arg) @markup.heading
	(#has-parent? @markup.heading preproc_region preproc_endregion)
)

(
	[
		(preproc_region)
		(preproc_endregion)
	] @punctuation.special
	(#offset-from! "start" @punctuation.special 0 0 0 1)
	(#set! "priority" 101)
)
