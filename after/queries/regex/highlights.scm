;; extends

; punctuation

[
	(start_assertion)
	(end_assertion)
] @punctuation.special

(character_class
	(class_character) @_range_start
	.
	(class_character) @operator
	.
	(class_character) @_range_end

	(#lua-match? @_range_start "[0-8]")
	(#lua-match? @_range_end "[1-9]")
	(#eq? @operator "-")

	(#set! "priority" 101)
)

(character_class
	(class_character) @_range_start
	.
	(class_character) @operator
	.
	(class_character) @_range_end

	(#lua-match? @_range_start "[a-y]")
	(#lua-match? @_range_end "[b-z]")
	(#eq? @operator "-")

	(#set! "priority" 101)
)

(character_class
	(class_character) @_range_start
	.
	(class_character) @operator
	.
	(class_character) @_range_end

	(#lua-match? @_range_start "[A-Y]")
	(#lua-match? @_range_end "[B-Z]")
	(#eq? @operator "-")

	(#set! "priority" 101)
)

; qualifiers

(
	[
		(one_or_more)
		(optional)
		(zero_or_more)
	] @keyword.repeat
	(#set! "priority" 101)
)

; text

[
	(class_character)
	(identity_escape)
] @character

(decimal_digits) @number
