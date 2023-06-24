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
	(keyword_hash)
	(keyword_spgist)
] @function.builtin

(invocation (object_reference
	name: (identifier) @function.builtin
	(#lua-match? @function.builtin "[Cc][Oo][Nn][Cc][Aa][Tt]")
))

; ; identifiers
; (column (identifier) @field)
; (column_definition name: (identifier) @field)
; (field name: (identifier) @field)
(create_table (object_reference name: (identifier) @structure))
(keyword_null) @constant.builtin
(relation (object_reference name: (identifier) @structure))

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
