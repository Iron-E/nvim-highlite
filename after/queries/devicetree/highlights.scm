;; extends

; nodes

(node name: (identifier) @structure)
(reference
	"&" @punctuation.special
	label: (identifier) @label
)

; preprocs

; #bar
((_) . _ @punctuation.special
	(#lua-match? @punctuation.special "^#")
	(#offset-from! "start" @punctuation.special 0 0 0 1)
)

; #foo = "bar"
(property name: (identifier) @punctuation.special @keyword.directive
	(#lua-match? @punctuation.special "^#")
	(#offset! @keyword.directive 0 1 0 0)
	(#offset-from! "start" @punctuation.special 0 0 0 1)
)

; #define
((preproc_def) @keyword.directive.define
	(#offset-from! "start" @keyword.directive.define 0 1 0 7)
)

; #ifdef
(preproc_ifdef "#ifdef" @keyword.directive.conditional
	(#offset-from! "start" @keyword.directive.conditional 0 1 0 7)
)

; #ifndef
(preproc_ifdef "#ifndef" @keyword.directive.conditional
	(#offset-from! "start" @keyword.directive.conditional 0 1 0 8)
)

; #endif
(preproc_ifdef "#endif" @keyword.directive.conditional
	(#offset-from! "end" @keyword.directive.conditional 0 -5 0 0)
)
