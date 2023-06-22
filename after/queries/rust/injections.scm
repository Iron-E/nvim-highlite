;; extends

(macro_invocation
	macro: (scoped_identifier
		path: (identifier) @_path (#eq? @_path "sqlx")
		name: (identifier) @_name (#any-of? @_name "query" "query_as")
	)
	(token_tree (string_literal) @sql
		(#offset! @sql 0 1 0 -1)
		(#set! "priority" 102)
	)
)

(macro_invocation
	macro: (scoped_identifier
		path: (identifier) @_path (#eq? @_path "sqlx")
		name: (identifier) @_name (#any-of? @_name "query" "query_as")
	)
	(token_tree (raw_string_literal) @sql
		(#lua-match? @sql "^r\"")
		(#offset! @sql 0 2 0 -1)
		(#set! "priority" 102)
	)
)

(macro_invocation
	macro: (scoped_identifier
		path: (identifier) @_path (#eq? @_path "sqlx")
		name: (identifier) @_name (#any-of? @_name "query" "query_as")
	)
	(token_tree (raw_string_literal) @sql
		(#lua-match? @sql "^r#\"")
		(#offset! @sql 0 3 0 -2)
		(#set! "priority" 102)
	)
)

(macro_invocation
	macro: (scoped_identifier
		path: (identifier) @_path (#eq? @_path "sqlx")
		name: (identifier) @_name (#any-of? @_name "query" "query_as")
	)
	(token_tree (raw_string_literal) @sql
		(#lua-match? @sql "^r##\"")
		(#offset! @sql 0 4 0 -3)
		(#set! "priority" 102)
	)
)

(macro_invocation
	macro: (scoped_identifier
		path: (identifier) @_path (#eq? @_path "sqlx")
		name: (identifier) @_name (#any-of? @_name "query" "query_as")
	)
	(token_tree (raw_string_literal) @sql
		(#lua-match? @sql "^r###\"")
		(#offset! @sql 0 5 0 -4)
		(#set! "priority" 102)
	)
)
