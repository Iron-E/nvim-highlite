;; extends

((comment) @injection.content
  (#lua-match? @injection.content "^///")
  (#offset! @injection.content 0 4 0 0)
  (#set! injection.language "xml")
  (#set! injection.combined)
)
