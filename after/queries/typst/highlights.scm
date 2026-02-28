;; extends

; builtins (this is excessive…)

((#set! "priority" 126)
  [
    (auto)
    (none)
  ] @constant.builtin
)

((ident) @constant.builtin
  (#set! "priority" 126)
  (#any-of? @constant.builtin
    ; alignment
    "bottom" "top"
    "center" "horizon"
    "end" "start"
    "left" "right"

    ; directions
    "btt" "ltr" "rtl" "ttb"

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
  )
)

((ident) @type.builtin
  (#set! "priority" 128)
  (#not-has-parent? @type.builtin call)
  (#any-of? @type.builtin
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
  )
)

(call item: (ident) @function.builtin
  (#set! "priority" 126)
  (#any-of? @function.builtin
    "accent"
    "align"
    "alignment"
    "angle"
    "arguments"
    "array"
    "attach"
    "bibliography"
    "block"
    "boolean"
    "box"
    "cancel"
    "cases"
    "cbor"
    "circle"
    "cite"
    "class"
    "colbreak"
    "color"
    "columns"
    "content"
    "counter"
    "csv"
    "datetime"
    "dictionary"
    "direction"
    "document"
    "duration"
    "ellipse"
    "emph"
    "enum"
    "equation"
    "eval"
    "figure"
    "float"
    "footnote"
    "frac"
    "fraction"
    "function"
    "gradient"
    "grid"
    "h"
    "heading"
    "hide"
    "highlight"
    "image"
    "int"
    "json"
    "label"
    "layout"
    "length"
    "line"
    "linebreak"
    "link"
    "list"
    "locate"
    "location"
    "lorem"
    "lower"
    "lr"
    "mat"
    "measure"
    "metadata"
    "module"
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
    "plugin"
    "polygon"
    "query"
    "quote"
    "ratio"
    "raw"
    "read"
    "rect"
    "ref"
    "regex"
    "relative"
    "repeat"
    "repr"
    "rgb"
    "roots"
    "rotate"
    "scale"
    "selector"
    "sizes"
    "smallcaps"
    "smartquote"
    "square"
    "stack"
    "state"
    "str"
    "strike"
    "stroke"
    "strong"
    "style"
    "styles"
    "sub"
    "super"
    "table"
    "terms"
    "text"
    "toml"
    "type"
    "underline"
    "underover"
    "upper"
    "v"
    "variants"
    "vec"
    "version"
    "xml"
    "yaml"
  )
)

(branch
  (#set! "priority" 126)
  [
    "if"
    "else"
  ] @keyword.conditional
)

(call (ident) @keyword.exception
  (#set! "priority" 126)
  (#eq? @keyword.exception "panic")
)

(import
  (#set! "priority" 126)

  "import" @keyword.import
  (#eq? @keyword.import "import")

  import: (string) @string.special.path
  (#offset! @string.special.path 0 1 0 -1)
)

(field (ident) @module.builtin
  (#set! "priority" 126)
  (#any-of? @module.builtin
    "calc"
    "sym"
    "system"
  )
)

(tagged field: (ident) @variable.member
  (#set! "priority" 129)
  (#any-of? @variable.member
    "accent"
    "align"
    "alignment"
    "angle"
    "aqua"
    "arguments"
    "array"
    "attach"
    "bibliography"
    "black"
    "block"
    "blue"
    "boolean"
    "bottom"
    "box"
    "btt"
    "calc"
    "cancel"
    "cases"
    "cbor"
    "center"
    "circle"
    "cite"
    "class"
    "colbreak"
    "color"
    "columns"
    "content"
    "counter"
    "csv"
    "datetime"
    "dictionary"
    "direction"
    "document"
    "duration"
    "eastern"
    "ellipse"
    "emph"
    "end"
    "enum"
    "equation"
    "eval"
    "figure"
    "float"
    "footnote"
    "frac"
    "fraction"
    "fuchsia"
    "function"
    "gradient"
    "gray"
    "green"
    "grid"
    "h"
    "heading"
    "hide"
    "highlight"
    "horizon"
    "image"
    "int"
    "json"
    "label"
    "layout"
    "left"
    "length"
    "lime"
    "line"
    "linebreak"
    "link"
    "list"
    "locate"
    "location"
    "lorem"
    "lower"
    "lr"
    "ltr"
    "maroon"
    "mat"
    "measure"
    "metadata"
    "module"
    "move"
    "navy"
    "numbering"
    "olive"
    "op"
    "orange"
    "outline"
    "overline"
    "pad"
    "page"
    "pagebreak"
    "panic"
    "par"
    "parbreak"
    "path"
    "pattern"
    "place"
    "plugin"
    "polygon"
    "purple"
    "query"
    "quote"
    "ratio"
    "raw"
    "read"
    "rect"
    "red"
    "ref"
    "regex"
    "relative"
    "repeat"
    "repr"
    "right"
    "roots"
    "rotate"
    "rtl"
    "scale"
    "selector"
    "silver"
    "sizes"
    "smallcaps"
    "smartquote"
    "square"
    "stack"
    "start"
    "state"
    "str"
    "strike"
    "stroke"
    "strong"
    "style"
    "styles"
    "sub"
    "super"
    "sym"
    "system"
    "table"
    "teal"
    "terms"
    "text"
    "toml"
    "top"
    "ttb"
    "type"
    "underline"
    "underover"
    "upper"
    "v"
    "variants"
    "vec"
    "version"
    "white"
    "xml"
    "yaml"
    "yellow"
  )
)

; markup

[
  (linebreak)
  (parbreak)
] @punctuation.special

(call
  item: (call
    item: (ident) @_call
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

; punctuation

("#" @punctuation.special (#set! "priority" 126))

[
  "assign"
  ".."
] @operator

(field "." @punctuation.delimiter)
(lambda "=>" @punctuation.delimiter)
