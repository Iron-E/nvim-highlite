;; extends

; TODO: remove this capture in the future.
; the @text group doesn't exist anymore, but it did when this was written.
; some people might be using this still.
(CharData) @text

((CharData) @boolean (#any-of? @boolean "true" "false"))
((CharData) @number (#lua-match? @number "^%d+$"))
((CharData) @number.float (#lua-match? @number.float "^%d+.%d*$"))
