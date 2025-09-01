;; extends

; Constants

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


; Punctuation
(decorator "@" @punctuation.special (#set! "priority" 101))
