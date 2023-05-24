;; extends

(macro_invocation
	macro: (scoped_identifier
		path: (identifier) @_path (#eq? @_path "sqlx")
		name: (identifier) @_name (#any-of? @_name "query" "query_as")
	)
	(token_tree
		[
			(string_literal)
			(raw_string_literal)
		] @sql
	)
) @foo
