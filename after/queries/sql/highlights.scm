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
(column_definition name: (identifier) @field)
(keyword_null) @constant.builtin
(table_reference name: (identifier) @structure)

; operators
[
	(keyword_as)
	(keyword_cast)
] @keyword.operator
