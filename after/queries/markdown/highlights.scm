;; extends

; punctuation
((list_marker_dot) @punctuation.delimiter (#offset-from! "end" @punctuation.delimiter 0 -2 0 0))

(link_reference_definition
	(link_label ["[" "]"] @punctuation.bracket)
	":" @punctuation.delimiter
)

; text environments
(fenced_code_block (info_string) @markup.environment.name (#set! priority 101))
