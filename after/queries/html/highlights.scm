;; extends

; doctype as preproc (i.e. shebang)
(doctype) @preproc

; headers
(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h1"))
	(text) @text.title.h1
)

(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h2"))
	(text) @text.title.h2
)

(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h3"))
	(text) @text.title.h3
)

(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h4"))
	(text) @text.title.h4
)

(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h5"))
	(text) @text.title.h5
)

(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h6"))
	(text) @text.title.h6
)
