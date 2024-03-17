;; extends

; modules

(apply_expression ; `import` args
	function: (variable_expression
		name: (identifier) @_fn
		(#eq? @_fn "import")
	)

	argument: [
		(path_expression (path_fragment) @module)
		(spath_expression) @module
	]
)

(binding ; imports in nixos and home-manager modules
	attrpath: (attrpath
		attr: (identifier) @_key
		(#eq? @_key "imports")
	)

	expression: (list_expression
		element: (path_expression (path_fragment) @module)
	)
)

; punctuation

(binding "=" @operator)

(function_expression [
	"@" @operator
	":" @punctuation.delimiter
])

(ellipses) @variable.builtin

(has_attr_expression "?" @operator)
