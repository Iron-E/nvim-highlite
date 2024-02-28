;; extends

; punctuation

[
	(start_assertion)
	(end_assertion)
] @punctuation.special

(character_class "^" @punctuation.special)

; qualifiers

(
	[
		(one_or_more)
		(optional)
		(zero_or_more)
	] @repeat
	(#set! "priority" 101)
)

; text

[
	(class_character)
	(identity_escape)
] @character

(decimal_digits) @number
