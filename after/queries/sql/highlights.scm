;; extends

; conditionals
(keyword_if) @keyword.conditional

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
; (column (identifier) @variable.member)
; (column_definition name: (identifier) @variable.member)
; (field name: (identifier) @variable.member)
(all_fields (object_reference name: (identifier) @variable) "*" @character.special)
(create_table (object_reference name: (identifier) @structure))
(field (object_reference name: (identifier) @variable))
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
((parameter) @punctuation.special (#offset-from! "start" @punctuation.special 0 0 0 1))
