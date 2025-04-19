;; extends

; keywords
(ERROR
	.
	(ERROR) @keyword.directive
	.
	"="
	.
	"\"" @string.special
	.
	(decimal_lit) @string.special
	.
	"\"" @string.special
	.

	(#eq? @keyword.directive "edition")
)

; punctuation
(full_ident
	[
		(identifier) @module
		"." @punctuation.delimiter
	]
)

(message_or_enum_type "." @punctuation.delimiter)

; types

(message_or_enum_type
	(identifier) @module
	(#lua-match? @module "^[a-z]")
)

(message_or_enum_type
	(identifier) @structure
	(#lua-match? @structure "^[A-Z]")
)

(
	(type
		.
		_ @_type
		(#not-kind-eq? @_type "message_or_enum_type")
	) @type.builtin
	(#set! "priority" 126)
)

(rpc_name (identifier) @function)
(rpc "stream" @keyword.repeat)
