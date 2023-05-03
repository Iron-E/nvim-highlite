;; extends

(operation (command) @_command (label) @label (#any-of? @_command "l" "label"))
(operation (command) @_command (label) @number (#not-any-of? @_command "l" "label"))
(operation (command) @text.danger (#any-of? @text.danger "d" "drop"))
(operation (command) @include (#any-of? @include
	"e" "edit"
	"f" "fixup"
	"p" "pick"
	"r" "reword"
	"s" "squash"
))
