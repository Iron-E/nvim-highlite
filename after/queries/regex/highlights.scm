;; extends

; punctuation

[
	(start_assertion)
	(end_assertion)
] @punctuation.special

; text

[
	(class_character)
	(identity_escape)
] @character

(decimal_digits) @number
