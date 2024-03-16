;; extends

; accessors as operator-keywords
(accessor_declaration _ @keyword.operator (#not-eq? @keyword.operator ";"))

; arrows as delimiters
"=>" @punctuation.delimiter

; identifiers
((identifier) @variable.builtin (#eq? @variable.builtin "_"))

; interpolations with the dedicated interpolation group
(interpolation ["{" "}"] @punctuation.special)

; lambda
(lambda_expression
	parameters: (parameter_list . "(" @function ")" @function .)
)

; macro
(region_directive (preproc_message) @markup.title) @keyword.directive
(endregion_directive (preproc_message) @markup.title) @keyword.directive

(
	[
		(region_directive)
		(endregion_directive)
	] @punctuation.special
	(#offset-from! "start" @punctuation.special 0 -1 0 0)
)

; modifier
(modifier "file" @keyword.modifier)

; namespaces
(using_directive (identifier) @module)
(qualified_name (identifier) @module
	(#has-ancestor? @module namespace_declaration using_directive) ; NOTE: from nvim-treesitter
)

; nullable
(conditional_access_expression "?" @punctuation.special)
(nullable_type "?" @punctuation.special)

; operators
(binary_expression "??" @operator)
