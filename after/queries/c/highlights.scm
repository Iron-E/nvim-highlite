;; extends

; member accessor
"->" @punctuation.delimiter
(field_expression "." @punctuation.delimiter)

; de/ref
(abstract_pointer_declarator "*" @keyword.storage)
(pointer_declarator "*" @keyword.storage)
(pointer_expression ["*" "&"] @keyword.storage)

; preprocessors
(preproc_if ["#if" "#endif"] @keyword.directive.conditional)

(
	[
		(preproc_def "#define" @punctuation.special)
		(preproc_directive) @punctuation.special
		(preproc_else "#else" @punctuation.special)
		(preproc_if ["#if" "#endif"] @punctuation.special)
		(preproc_include "#include" @punctuation.special)
	]
	(#offset-from! "start" @punctuation.special 0 0 0 1)
)

(preproc_include path: _ @module (#offset! @module 0 1 0 -1))
((system_lib_string) @punctuation.bracket (#offset-from! "start" @punctuation.bracket 0 0 0 1))
((system_lib_string) @punctuation.bracket (#offset-from! "end" @punctuation.bracket 0 -1 0 0))
