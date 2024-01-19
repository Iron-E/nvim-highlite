;; extends

; builtins
(
	[
		(iota) @variable.builtin
		(nil) @constant.builtin
		[(false) (true)] @boolean
	]
	(#set! "priority" 128)
)

((identifier) @variable.builtin
	(#eq? @variable.builtin "_")
	(#set! "priority" 128)
)

; namespace
(import_spec path: _ @module (#offset! @module 0 1 0 -1))

; storageclass
(const_declaration "const" @keyword.storage)
(pointer_type "*" @keyword.storage)
(unary_expression ["*" "&"] @keyword.storage)
