;; extends

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

; operators
[
	(keyword_as)
	(keyword_cast)
] @keyword.operator

; structures
(field table_alias: (identifier) @structure)
(relation table_alias: (identifier) @structure)
