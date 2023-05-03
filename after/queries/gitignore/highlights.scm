;; extends

[
	(wildcard_chars)
	(wildcard_chars_allow_slash)
] @character.special

((pattern_char) @punctuation.delimiter
	(#eq? @punctuation.delimiter ".")
)
