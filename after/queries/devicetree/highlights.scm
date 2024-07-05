;; extends

; identifiers

((identifier) @constant
	(#not-has-parent? @constant preproc_def)
	(#match? @constant "^_*[A-Z0-9]+(_[A-Z0-9]+)*_*$")
)

(node name: (identifier) @structure)

; labels

(reference
	"&" @punctuation.special
	label: (identifier) @label
)

; preprocs

; #foo = "bar"
((_) . _ @punctuation.special @keyword.directive
	(#lua-match? @punctuation.special "^#")
	(#offset! @keyword.directive 0 1 0 0)
	(#offset-from! "start" @punctuation.special 0 0 0 1)
)

; #define
(preproc_def
	"#define" @keyword.directive.define (#offset-from! "start" @keyword.directive.define 0 1 0 7)
	value: (preproc_arg) @constant.macro
)

; #if
(preproc_if "#if" @keyword.directive.conditional
	(#offset-from! "start" @keyword.directive.conditional 0 1 0 3)
)

; #ifdef
(preproc_ifdef "#ifdef" @keyword.directive.conditional
	(#offset-from! "start" @keyword.directive.conditional 0 1 0 7)
)

; #ifndef
(preproc_ifdef "#ifndef" @keyword.directive.conditional
	(#offset-from! "start" @keyword.directive.conditional 0 1 0 8)
)

; #else
(preproc_else "#else" @keyword.directive.conditional
	(#offset-from! "end" @keyword.directive.conditional 0 -3 0 0)
)

; #endif
(preproc_ifdef "#endif" @keyword.directive.conditional
	(#offset-from! "end" @keyword.directive.conditional 0 -5 0 0)
)

; #import
(preproc_include
	"#include" @keyword.import (#offset-from! "start" @keyword.import 0 1 0 8)
	path: (system_lib_string) @module (#offset! @module 0 1 0 -1)
)
