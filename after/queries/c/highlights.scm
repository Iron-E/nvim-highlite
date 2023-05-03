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
		(preproc_def "#define" @punctuation.delimiter)
		(preproc_directive) @punctuation.delimiter
		(preproc_else "#else" @punctuation.delimiter)
		(preproc_if ["#if" "#endif"] @punctuation.delimiter)
		(preproc_include "#include" @punctuation.delimiter)
	]
	(#offset-from-start! @punctuation.delimiter 0 0 0 1)
)

(preproc_include path: _ @namespace (#offset! @namespace 0 1 0 -1))
((system_lib_string) @punctuation.bracket (#offset-from-start! @punctuation.bracket 0 0 0 1))
((system_lib_string) @punctuation.bracket (#offset-from-end! @punctuation.bracket 0 -1 0 0))
