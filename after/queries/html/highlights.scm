;; extends

; doctype as preproc (i.e. shebang)
(doctype) @preproc

; headers
(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h1"))
	(text) @text.title.1
)

(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h2"))
	(text) @text.title.2
)

(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h3"))
	(text) @text.title.3
)

(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h4"))
	(text) @text.title.4
)

(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h5"))
	(text) @text.title.5
)

(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h6"))
	(text) @text.title.6
)
