;; extends

; conditionals
(keyword_if) @conditional

; functions
[
	(keyword_array)
	(keyword_brin)
	(keyword_btree)
	(keyword_float)
	(keyword_gin)
	(keyword_gist)
	(keyword_group_concat)
	(keyword_hash)
	(keyword_spgist)
] @function.builtin

; identifiers
(column (identifier) @field)
(column_definition name: (identifier) @field)
(field name: (identifier) @field)
(keyword_null) @constant.builtin
(object_reference name: (identifier) @structure)
((identifier) @variable.builtin
	(#eq? @variable.builtin "EXCLUDED")
)

; events
(keyword_conflict) @event

; operators
[
	(keyword_as)
	(keyword_cast)
] @keyword.operator

; punctuation
(parameter "$" @punctuation.special)
