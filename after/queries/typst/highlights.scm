;; extends

; builtins

[
	(auto)
	(none)
] @constant.builtin

((builtin) @constant.builtin (#any-of? @constant.builtin
	; alignment
	"bottom"
	"center"
	"end"
	"horizon"
	"left"
	"right"
	"start"
	"top"

	; color
	"aqua"
	"black"
	"blue"
	"bottom"
	"eastern"
	"fuchsia"
	"gray"
	"green"
	"lime"
	"maroon"
	"navy"
	"olive"
	"orange"
	"purple"
	"red"
	"silver"
	"teal"
	"white"
	"yellow"

	; directions
	"btt"
	"ltr"
	"rtl"
	"ttb"
))

((builtin) @function.builtin (#any-of? @function.builtin
	"accent"
	"align"
	"angle"
	"attach"
	"bibliography"
	"block"
	"box"
	"cancel"
	"cases"
	"cbor"
	"circle"
	"cite"
	"class"
	"colbreak"
	"columns"
	"counter"
	"csv"
	"document"
	"ellipse"
	"emph"
	"enum"
	"equation"
	"eval"
	"figure"
	"footnote"
	"frac"
	"fraction"
	"grid"
	"h"
	"heading"
	"hide"
	"highlight"
	"image"
	"json"
	"layout"
	"line"
	"linebreak"
	"link"
	"list"
	"locate"
	"lorem"
	"lower"
	"lr"
	"mat"
	"measure"
	"metadata"
	"move"
	"numbering"
	"op"
	"outline"
	"overline"
	"pad"
	"page"
	"pagebreak"
	"par"
	"parbreak"
	"path"
	"pattern"
	"place"
	"polygon"
	"query"
	"quote"
	"ratio"
	"raw"
	"read"
	"rect"
	"ref"
	"relative"
	"repeat"
	"repr"
	"roots"
	"rotate"
	"scale"
	"sizes"
	"smallcaps"
	"smartquote"
	"square"
	"stack"
	"state"
	"strike"
	"strong"
	"style"
	"styles"
	"sub"
	"super"
	"table"
	"terms"
	"text"
	"toml"
	"underline"
	"underover"
	"upper"
	"v"
	"variants"
	"vec"
	"xml"
	"yaml"
))

((builtin) @keyword.exception (#any-of? @keyword.exception
	"panic"
))

((builtin) @module.builtin (#any-of? @module.builtin
	"calc"
	"sym"
	"system"
))

((builtin) @type.builtin (#any-of? @type.builtin
	"alignment"
	"arguments"
	"array"
	"boolean"
	"color"
	"content"
	"datetime"
	"dictionary"
	"direction"
	"duration"
	"float"
	"function"
	"gradient"
	"int"
	"label"
	"length"
	"location"
	"module"
	"plugin"
	"regex"
	"selector"
	"str"
	"stroke"
	"type"
	"version"
))

; markup

[
	(linebreak)
	(parbreak)
] @punctuation.special

(call
	item: (call
		item: (builtin) @_call
		(group (string) @markup.link.url)
	)

	(content (text) @markup.link.label)
	(#eq? @_call "link")
)


(heading "=" @punctuation.special (text) @markup.heading.1)
(heading "==" @punctuation.special (text) @markup.heading.2)
(heading "===" @punctuation.special (text) @markup.heading.3)
(heading "====" @punctuation.special (text) @markup.heading.4)
(heading "=====" @punctuation.special (text) @markup.heading.5)
(heading "======" @punctuation.special (text) @markup.heading.6)

(item "-" @markup.list)

(emph "_" @markup.environment (#set! conceal ""))
(strong "*" @markup.environment (#set! conceal ""))

; members

(field field: (ident) @variable.member)
(call item: (field
	field: (ident) @function.call
))

(
	(field
		[
			(builtin) @_module
			(field
				(builtin) @_module
				field: (ident) @module.builtin
			)
		]
		field: (ident) @constant.builtin
	) @_field
	(#any-of? @_module "calc" "sym" "system")
)

; punctuation

[
	"assign"
	".."
] @operator

(field "." @punctuation.delimiter)
(lambda "=>" @punctuation.delimiter)
