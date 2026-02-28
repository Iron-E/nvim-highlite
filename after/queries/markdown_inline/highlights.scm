;; extends

; punctuation

(image "!" @punctuation.special)

(
  [
    "[" "]"
    "(" ")"
  ] @punctuation.bracket
  (#has-parent? @punctuation.bracket full_reference_link image inline_link link_label shortcut_link)
)

("[" @punctuation.bracket
  . (shortcut_link
    . "["
    . (link_text) @markup.link
    . "]"
    .)
  . "]" @punctuation.bracket)
