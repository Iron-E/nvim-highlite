;; extends

(operation
  (command) @_command
  (message) @injection.content
  (#any-of? @_command
    "d" "drop"
    "e" "edit"
    "f" "fixup"
    "m" "merge"
    "p" "pick"
    "r" "reword"
    "s" "squash"
    "p" "pick"
    "r" "reword"
  )

  (#offset! @injection.content 0 2 0 0)
  (#set! injection.language "gitcommit")
)
