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
(
	[
		"#define"
		"#if" "#ifdef" "#ifndef" "#else" "#endif"
 		"#include"
	] @punctuation.special
	(#lua-match? @punctuation.special "^#")
	(#offset-from! "start" @punctuation.special 0 0 0 1)
	(#set! "priority" 101)
)

; #define
(preproc_def
	"#define" @keyword.directive.define (#offset-from! "start" @keyword.directive.define 0 1 0 7)
	value: (preproc_arg) @constant.macro
)

; #if
(preproc_if ["#if" "#endif"] @keyword.directive.conditional)
(preproc_ifdef ["#ifdef" "#ifndef" "#endif"] @keyword.directive.conditional)
(preproc_else "#else" @keyword.directive.conditional)

; #import
(preproc_include
	"#include" @keyword.import (#offset-from! "start" @keyword.import 0 1 0 8)
	path: (system_lib_string) @module (#offset! @module 0 1 0 -1)
)
