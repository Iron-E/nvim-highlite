;; extends

; Privates
((identifier) @type (#lua-match? @type "^_+[A-Z]+[a-z]+"))
((identifier) @constant (#lua-match? @constant "^[A-Z_]+$"))
