;; extends

; decorator
(decorator "@" @punctuation.special
	(#set! "priority" 101)
)

; namespaces
(aliased_import alias: (identifier) @namespace)
(
	[
		(import_from_statement module_name: (dotted_name (identifier) @namespace))
		(import_statement name:
		[
			(aliased_import name: (dotted_name (identifier) @namespace))
			(dotted_name (identifier) @namespace)
		])
	]
	(#lua-match? @namespace "^[a-z_0-9]+$")
)

; repeats
(for_in_clause "in" @repeat)
(for_statement "in" @repeat)

; shebang
((comment) @preproc (#lua-match? @preproc "^#!"))
