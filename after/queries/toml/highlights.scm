;; extends

; show tables as structures
(dotted_key (bare_key) @structure)

(pair (bare_key) @structure (inline_table))
(pair
	(dotted_key (bare_key) @field .)
	(_) @_value
	(#not-has-type? @_value inline_table)
)

(table (bare_key) @structure)
(table_array_element (bare_key) @structure)
