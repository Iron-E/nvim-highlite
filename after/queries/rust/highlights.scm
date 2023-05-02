;; extends
;; NOTE: TS rust highlight queries are a big tangled mess. I gave up.

; highlight closure delimiter as @function (it is an anonymous function)
(closure_parameters . ("|" @function) ("|" @function) .)

; highlight the valid "~" as storageclass
((ERROR) @storageclass
	(#eq? @storageclass "~")
	(#offset-from-start! @storageclass 0 0 0 1)
)

; Highlight 'foo.r#bar' with special punctuation
((field_identifier) @punctuation.special
	(#lua-match? @punctuation.special "^r#")
	(#offset-from-start! @punctuation.special 0 0 0 2)
)

; Highlight 'r#foo' with special punctuation
((identifier) @punctuation.special
	(#lua-match? @punctuation.special "^r#")
	(#offset-from-start! @punctuation.special 0 0 0 2)
)

; highlight attributes as attributes
(inner_attribute_items)

; higlhight includes as includes
(macro_invocation
  macro: (identifier) @include
  "!" @include.invocation
  (#any-of? @include "include" "include_str")
)

; highlight the de/ref characters as storageclass
(reference_expression . "&" @storageclass)
(reference_pattern . "&" @storageclass)
(reference_type . "&" @storageclass)
(self_parameter . "&" @storageclass)
(unary_expression . "*" @storageclass)

; highlight `foo.bar()?` as exception
(try_expression ("?" @exception))
