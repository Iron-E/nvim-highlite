;; extends

; punctuation

(code_span_delimiter) @markup.environment
(emphasis_delimiter) @markup.environment
(image "!" @punctuation.special)

(
	[
		"[" "]"
		"(" ")"
	] @markup.environment
	(#has-parent? @markup.environment full_reference_link image inline_link link_label shortcut_link)
)

((link_label) @markup.link (#offset! @markup.link 0 1 0 -1))
(shortcut_link (link_text) @markup.link)
