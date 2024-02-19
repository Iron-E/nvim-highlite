;; extends

; in `foo.bar = "baz"`, `foo` shows as `@structure`
(dotted_key (bare_key) @structure (bare_key) .)

(; in `[foo.bar]` or `[[foo.bar]]` show `bar` as structure
	(dotted_key (bare_key) @structure .) @_parent
	(#not-has-parent? @_parent pair)
)

; in `[foo]` and `[[foo]]`, show `foo` as structure
(table . (bare_key) @structure)
(table_array_element . (bare_key) @structure)
