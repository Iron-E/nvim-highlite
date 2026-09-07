;; extends

; punctuation

[
  (assignment)
  (in)
  "-"
] @operator

("|" @punctuation.delimiter
 (#has-parent? @punctuation.delimiter object_compr array_compr set_compr))

[
  ","
  "."
  ":"
  ";"
] @punctuation.delimiter

(ERROR [
  ")"
  "{" "}"
] @punctuation.bracket)

([
   "$\""
   "$`"
 ] @punctuation.special
 (#offset! @punctuation.special 0 0 0 -1))

(interpolation [ "{" "}" ] @punctuation.special)

; identifiers

(empty_set
  "set(" @type.builtin @punctuation.delimiter
  ")" @punctuation.delimiter
  (#offset! @type.builtin 0 0 0 -1)
  (#offset! @punctuation.delimiter 0 3 0 0))

(scalar "null" @constant.builtin
        (#eq? @constant.builtin "null"))

((var) @variable.builtin
       (#any-of? @variable.builtin "_" "data" "input" "metadata"))

(ref_arg_brack "_" @variable.builtin)

((import)
 . (ref
     (var) @_head @module.builtin
     (ref_arg (ref_arg_dot (var) @module.builtin))*)

 (#any-of? @_head "rego" "future"))

((import) . (ref) . (as) @keyword.import)

(rule_head
  . (var) @variable
  (#set! priority 105))

(rule_head
  . (var) @function
  (rule_args)
  (#set! priority 105))

; The default queries set this to @module
(rule_head (term (ref (var) @variable)))

; keywords

([
  (some)
  (every)
 ] @keyword.repeat
 (in) @keyword.repeat)

[
  (and)
  (contains)
  (not)
  (or)
] @keyword.operator

[
  (if)
  (else)
] @keyword.conditional

(with_modifier
  (with) @keyword.modifier
  (as) @keyword.operator)

; highlights `contains` in `foo[bar] contains baz if { ... }` correctly.
; the parser thinks it is two distinct rules.
(policy
  . (rule
      (rule_head (var) (open_bracket) (term) (close_bracket))
      (rule_body (literal (expr (term (ref (var) @keyword.operator))))))
  . (rule (rule_head (var) (if)))
  (#eq? @keyword.operator "contains"))
