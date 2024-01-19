;; extends

(operation (command) @_command (label) @label (#any-of? @_command "l" "label"))
(operation (command) @_command (label) @number (#not-any-of? @_command "l" "label"))
(operation (command) @markup.danger (#any-of? @markup.danger "d" "drop"))
(operation (command) @keyword.import (#any-of? @keyword.import
	"e" "edit"
	"f" "fixup"
	"p" "pick"
	"r" "reword"
	"s" "squash"
))
