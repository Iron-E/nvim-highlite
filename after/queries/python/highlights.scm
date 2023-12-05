;; extends

; Namespaces
(attribute
  object: (identifier) @namespace (#lua-match? @namespace "[_a-z]+")
  attribute: (identifier) @_type (#lua-match? @_type "^_*[A-Z]+[a-z]+")
)

(import_statement name: [
	(aliased_import [
		(dotted_name (identifier) @namespace)
		(identifier) @namespace
	])
	(dotted_name (identifier) @namespace)
])

(import_from_statement module_name: [
	(dotted_name (identifier) @namespace)
	(relative_import (dotted_name (identifier) @namespace))
])

; Privates
((identifier) @type (#lua-match? @type "^_+[A-Z]+[a-z]+"))
(
	(identifier) @constant
	(#lua-match? @constant "^_*[A-Z][A-Z_]*$")
	(#not-has-ancestor? @constant import_statement)
)

; Punctuation
(decorator "@" @punctuation.special (#set! "priority" 101))
