;; extends

(pair
  value: (string) @boolean
  (#any-of? @boolean "true" "false")
)

(pair
  value: (string) @number
  (#lua-match? @number "^%d+$")
)

(pair
  value: (string) @number.float
  (#lua-match? @number.float "^%d+%.%d+$")
)
