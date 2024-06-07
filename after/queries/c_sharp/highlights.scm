;; extends

; accessors as operator-keywords
(accessor_declaration _ @keyword.operator (#not-eq? @keyword.operator ";"))

; arrows as delimiters
"=>" @punctuation.delimiter

; identifiers
((identifier) @variable.builtin (#eq? @variable.builtin "_"))

; lambda
(lambda_expression
	parameters: (parameter_list . "(" @function ")" @function .)
)

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

; modifier
(modifier "file" @keyword.modifier)

; namespaces
(using_directive (identifier) @module)
(qualified_name (identifier) @module
	(#has-ancestor? @module using_directive) ; NOTE: from nvim-treesitter
)

; nullable
(conditional_access_expression "?" @punctuation.special)
(nullable_type "?" @punctuation.special)

; operators
(binary_expression "??" @operator)
(range_expression ".." @operator)
