;; extends

; annotations
(marker_annotation "@" @punctuation.special)

; lambda
(lambda_expression
	parameters: (formal_parameters . "(" @function ")" @function .)
)

; namespaces
(import_declaration (identifier) @module)
(import_declaration (asterisk) @character.special
	(#set! "priority" 101)
)

(package_declaration (identifier) @module)
(scoped_identifier
	[
		name: (identifier) @module
		scope: (identifier) @module
	] @_capture
	(#has-ancestor? @_capture import_declaration package_declaration) ; NOTE: from nvim-treesitter
)
