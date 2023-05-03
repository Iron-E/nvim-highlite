;; extends

; anonymous node
(anonymous_node "_" @variable.builtin)
(named_node "_" @variable.builtin)

; captures
(capture name: (identifier) @variable)

; predicates
(predicate
	name: (identifier) @_name (#any-of? @_name "has-ancestor" "has-parent" "not-has-ancestor" "not-has-parent")
	(parameters (identifier) @structure)
)

; named node
(named_node name: (identifier) @structure)

; quantifier
(quantifier) @repeat
