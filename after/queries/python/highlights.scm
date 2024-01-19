;; extends

; Constants

; BUG: this was copied directly from the nim TS queries (w/ small changes) , and it works over there but doesn't work here -_-
; (import_from_statement
; 	name: (aliased_import
; 		name: (dotted_name (identifier) @_const)
; 		alias: (identifier) @constant
; 	)
; 	(#lua-match? @_const "^_*[A-Z][A-Z_]*$")
; )

; Namespaces
(attribute
  object: (identifier) @module (#lua-match? @module "[_a-z]+")
  attribute: (identifier) @_type (#lua-match? @_type "^_*[A-Z]+[a-z]+")
)

(import_statement name: [
	(aliased_import [
		(dotted_name (identifier) @module)
		(identifier) @module
	])
	(dotted_name (identifier) @module)
])

(import_from_statement module_name: [
	(dotted_name (identifier) @module)
	(relative_import (dotted_name (identifier) @module))
])

; Privates
((identifier) @type (#lua-match? @type "^_+[A-Z]+[a-z]+"))
; (
; 	(identifier) @constant
; 	(#lua-match? @constant "^_*[A-Z][A-Z_]*$")
; 	(#not-has-parent? @constant aliased_import)
; )


; Punctuation
(decorator "@" @punctuation.special (#set! "priority" 101))
