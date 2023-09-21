;; extends

(macro_invocation
	macro: (scoped_identifier
		path: (identifier) @_path (#eq? @_path "sqlx")
		name: (identifier) @_name (#any-of? @_name "query" "query_as")
	)
	(token_tree (string_literal) @injection.content
		(#offset! @injection.content 0 1 0 -1)
		(#set! "priority" 102)
		(#set! injection.language "sql")
	)
)

(macro_invocation
	macro: (scoped_identifier
		path: (identifier) @_path (#eq? @_path "sqlx")
		name: (identifier) @_name (#any-of? @_name "query" "query_as")
	)
	(token_tree (raw_string_literal) @injection.content
		(#lua-match? @injection.content "^r\"")
		(#offset! @injection.content 0 2 0 -1)
		(#set! "priority" 102)
		(#set! injection.language "sql")
	)
)

(macro_invocation
	macro: (scoped_identifier
		path: (identifier) @_path (#eq? @_path "sqlx")
		name: (identifier) @_name (#any-of? @_name "query" "query_as")
	)
	(token_tree (raw_string_literal) @injection.content
		(#lua-match? @injection.content "^r#\"")
		(#offset! @injection.content 0 3 0 -2)
		(#set! "priority" 102)
		(#set! injection.language "sql")
	)
)

(macro_invocation
	macro: (scoped_identifier
		path: (identifier) @_path (#eq? @_path "sqlx")
		name: (identifier) @_name (#any-of? @_name "query" "query_as")
	)
	(token_tree (raw_string_literal) @injection.content
		(#lua-match? @injection.content "^r##\"")
		(#offset! @injection.content 0 4 0 -3)
		(#set! "priority" 102)
		(#set! injection.language "sql")
	)
)

(macro_invocation
	macro: (scoped_identifier
		path: (identifier) @_path (#eq? @_path "sqlx")
		name: (identifier) @_name (#any-of? @_name "query" "query_as")
	)
	(token_tree (raw_string_literal) @injection.content
		(#lua-match? @injection.content "^r###\"")
		(#offset! @injection.content 0 5 0 -4)
		(#set! "priority" 102)
		(#set! injection.language "sql")
	)
)
