;; extends

(call_expression
	function: (member_expression
		object: (identifier) @_object (#eq? @_object "JSON")
		property: (property_identifier) @_property (#eq? @_property "parse")
	)
	arguments: (arguments
		(template_string) @injection.content
		(#offset! @injection.content 0 1 0 -1)
		(#set! injection.language "json")
	)
)

(call_expression
	function: (member_expression
		object: (identifier) @_object (#eq? @_object "JSON")
		property: (property_identifier) @_property (#eq? @_property "parse")
	)
	arguments: (arguments (string
		(string_fragment) @injection.content
		(#set! injection.language "json")
	))
)
