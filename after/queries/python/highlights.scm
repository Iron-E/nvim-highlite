;; extends

; Namespaces
(attribute
  object: (identifier) @namespace (#lua-match? @namespace "[_a-z]+")
  attribute: (identifier) @_type (#lua-match? @_type "^_*[A-Z]+[a-z]+")
)

; Privates
((identifier) @type (#lua-match? @type "^_+[A-Z]+[a-z]+"))
((identifier) @constant (#lua-match? @constant "^[A-Z_]+$"))
