;; extends

(table .
[
	(bare_key) @structure
	(dotted_key (bare_key) @structure)
])

(table_array_element .
[
	(bare_key) @structure
	(dotted_key (bare_key) @structure)
])
