;; extends

; accessors as operator-keywords
(accessor_declaration _ @keyword.operator)

; arrows as delimiters
"=>" @punctuation.delimiter

; conditionals
(conditional_expression ["?" ":"] @conditional.ternary)

; identifiers
((identifier) @variable.builtin (#eq? @variable.builtin "_"))

; interpolations with the dedicated interpolation group
(interpolation ["{" "}"] @punctuation.special)

; lambda
(lambda_expression
	parameters: (parameter_list . "(" @function ")" @function .)
)

; macro
(region_directive (preproc_message) @text.title) @preproc
(endregion_directive (preproc_message) @text.title) @preproc

(
	[
		(region_directive)
		(endregion_directive)
	] @punctuation.delimiter
	(#offset-from-start! @punctuation.delimiter 0 -1 0 1)
)

; namespaces
(using_directive (identifier) @namespace)
(qualified_name (identifier) @namespace
	(#has-ancestor? @namespace namespace_declaration using_directive) ; NOTE: from nvim-treesitter
)

; nullable
(conditional_access_expression "?" @punctuation.special)
(nullable_type "?" @punctuation.special)

; operators
(binary_expression ["<" ">"] @operator)
(binary_expression "??" @operator)
