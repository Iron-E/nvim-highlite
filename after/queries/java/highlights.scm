;; extends

; annotations
(marker_annotation "@" @punctuation.special)

; generics
(type_arguments . "<" @punctuation.bracket ">" @punctuation.bracket .)
(type_parameters . "<" @punctuation.bracket ">" @punctuation.bracket .)

; lambda
(lambda_expression
	parameters: (formal_parameters . "(" @function ")" @function .)
)

; namespaces
(import_declaration (identifier) @namespace)
(import_declaration (asterisk) @character.special
	(#set! "priority" 101)
)

(package_declaration (identifier) @namespace)
(scoped_identifier
	[
		name: (identifier) @namespace
		scope: (identifier) @namespace
	] @_capture
	(#has-ancestor? @_capture import_declaration package_declaration) ; NOTE: from nvim-treesitter
)
