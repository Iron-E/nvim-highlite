;; extends

; punctuation
["(" ")"] @punctuation.bracket

; includes
(module_directive "module" @keyword.import)
(require_directive "require" @keyword.import)

; versions
[
	(go_version)
	(version)
] @string.special
