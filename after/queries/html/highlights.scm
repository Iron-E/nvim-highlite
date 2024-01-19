;; extends

; doctype as preproc (i.e. shebang)
(doctype) @keyword.directive

; headers
(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h1"))
	(text) @markup.title.1
)

(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h2"))
	(text) @markup.title.2
)

(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h3"))
	(text) @markup.title.3
)

(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h4"))
	(text) @markup.title.4
)

(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h5"))
	(text) @markup.title.5
)

(element
	(start_tag (tag_name) @_tag (#eq? @_tag "h6"))
	(text) @markup.title.6
)
