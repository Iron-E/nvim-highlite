;; extends

; interpolation
(command_substitution "`" @punctuation.special)

; repeat
(for_statement "in" @keyword.repeat)

; associative arrays
(array
	(concatenation
		.
		(word) @punctuation.bracket @_left_bracket
		(#eq? @_left_bracket "[")
		.
		(_) ; inner text
		.
		(word) @punctuation.bracket @_right_bracket
		(#eq? @_right_bracket "]")
		.
		(word) @operator
		(#lua-match? @operator "^%=") ; can't be eq, since if we have ['foo']=4 then (word) matches =4
		(#offset-from! "start" @operator 0 0 0 1)
	)
)
