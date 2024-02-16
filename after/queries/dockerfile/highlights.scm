;; extends

; character highlighting

[
	"="
] @operator

(
	[
		"{" "}"
		"[" "]"
	] @punctuation.bracket
	(#set! "priority" 99)
)

[
	":"
	","
	(line_continuation)
] @punctuation.delimiter


; paths
(path) @string.special.path
(image_name) @module

; values

(
	[
		(image_tag)
		(unquoted_string)
	] @string
	(#set! "priority" 99)
)

; variables
[
	(param)
	(mount_param_param)
] @parameter

(image_alias) @variable
(image_tag) @variable.member
