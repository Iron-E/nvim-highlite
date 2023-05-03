;; extends

; punctuation
["(" ")"] @punctuation.bracket

; includes
(module_directive "module" @include)
(require_directive "require" @include)

; versions
[
	(go_version)
	(version)
] @string.special
