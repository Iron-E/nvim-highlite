;; extends

; member accessor
"->" @punctuation.delimiter
(field_expression "." @punctuation.delimiter)

; de/ref
(abstract_pointer_declarator "*" @storageclass)
(pointer_declarator "*" @storageclass)
(pointer_expression ["*" "&"] @storageclass)

; preprocessors
(preproc_if ["#if" "#endif"] @preproc.conditional)

(
	[
		(preproc_def "#define" @punctuation.special)
		(preproc_directive) @punctuation.special
		(preproc_else "#else" @punctuation.special)
		(preproc_if ["#if" "#endif"] @punctuation.special)
		(preproc_include "#include" @punctuation.special)
	]
	(#offset-from-start! @punctuation.special 0 0 0 1)
)

(preproc_include path: _ @namespace (#offset! @namespace 0 1 0 -1))
((system_lib_string) @punctuation.bracket (#offset-from-start! @punctuation.bracket 0 0 0 1))
((system_lib_string) @punctuation.bracket (#offset-from-end! @punctuation.bracket 0 -1 0 0))
