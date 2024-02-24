;; extends

; character highlighting

"=" @operator

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

; params

[
	(param)
	(mount_param_param)
] @parameter

((mount_param_param) @structure (#match? @structure "^(--)?from\\=") (#offset! @structure 0 5 0 0))
((param) @structure (#match? @structure "^(--)?from\\=") (#offset! @structure 0 7 0 0))

((mount_param_param) @keyword.storage (#lua-match? @keyword.storage "^type%=") (#offset! @keyword.storage 0 5 0 0))
((mount_param_param) @number (#lua-match? @number "^[gu]id%=") (#offset! @number 0 4 0 0))
((mount_param_param) @number (#lua-match? @number "^mode%=") (#offset! @number 0 5 0 0))
((mount_param_param) @string (#lua-match? @string "^id%=") (#offset! @string 0 3 0 0))
((mount_param_param) @string.special.path (#match? @string.special.path "^(source|target)\\=") (#offset! @string.special.path 0 7 0 0))
((mount_param_param) @type.qualifier (#lua-match? @type.qualifier "^sharing%=") (#offset! @type.qualifier 0 8 0 0))

; values

(image_alias) @structure
(label_pair key: (_) @property)

(
	[
		(image_tag)
		(json_string)
		(unquoted_string)
	] @string
	(#set! "priority" 99)
)
