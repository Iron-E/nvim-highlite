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
(import_spec path: _ @namespace (#offset! @namespace 0 1 0 -1))

; storageclass
(const_declaration "const" @storageclass)
(pointer_type "*" @storageclass)
(unary_expression ["*" "&"] @storageclass)
