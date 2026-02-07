;; extends

; keywords

(val_variable . "$"  . name: "env" @constant.builtin)

((cmd_identifier) @keyword.return
	(#eq? @keyword.return "return"))

((cmd_identifier) @keyword.import
	(#eq? @keyword.import "export"))

; symbols

(command . head: "^" @punctuation.special)

[
	"..."
] @operator

(
	[
		"...$"
		"...["
		"...{"
	] @operator

	(#offset! @operator 0 0 0 -1)
)

[
	(long_flag_identifier)
	(short_flag_identifier)
] @variable.parameter

(val_interpolated
	expr: (expr_interpolated ["(" ")"] @punctuation.special))

(val_bool) @boolean
