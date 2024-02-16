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

("\"" @string (#set! conceal ""))


; paths
(path) @string.special.path
(image_name) @module

; values

(
	[
		(image_tag)
		(json_string)
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