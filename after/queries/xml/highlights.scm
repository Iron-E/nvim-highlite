;; extends

(CharData) @text
((CharData) @boolean (#any-of? @boolean "true" "false"))
((CharData) @number (#lua-match? @number "^%d+$"))
((CharData) @number.float (#lua-match? @number.float "^%d+.%d*$"))
