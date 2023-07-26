;; extends

(call_expression
	function: (member_expression
		object: (identifier) @_object (#eq? @_object "JSON")
		property: (property_identifier) @_property (#eq? @_property "parse")
	)
	arguments: (arguments (template_string) @json (#offset! @json 0 1 0 -1))
)

(call_expression
	function: (member_expression
		object: (identifier) @_object (#eq? @_object "JSON")
		property: (property_identifier) @_property (#eq? @_property "parse")
	)
	arguments: (arguments (string (string_fragment) @json))
)
