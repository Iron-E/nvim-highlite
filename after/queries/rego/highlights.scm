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
       (#any-of? @variable.builtin "_" "data" "input"))

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

(fn_name
  . (var) @module.builtin
  . (var) @function.builtin
  . (#any-of? @module.builtin
     "object"
     "regex"
     ))

((_) @_before
 . (comment) @keyword.directive
 (#not-any-kind-eq? @_before comment)
 (#eq? @keyword.directive "# METADATA")
 (#offset! @keyword.directive 0 1 0 0))

(source_file
 . (comment) @keyword.directive
 (#eq? @keyword.directive "# METADATA")
 (#offset! @keyword.directive 0 1 0 0))

(fn_name
  . (var) @function.builtin
  . (#any-of?
     "abs"
     "ceil"
     "concat"
     "contains"
     "count"
     "endswith"
     "floor"
     "format_int"
     "indexof_n"
     "intersection"
     "is_array"
     "is_boolean"
     "is_null"
     "is_number"
     "is_object"
     "is_set"
     "is_string"
     "lower"
     "max"
     "min"
     "print"
     "product"
     "replace"
     "round"
     "sort"
     "split"
     "sprintf"
     "startswith"
     "substring"
     "sum"
     "to_number"
     "trace"
     "trim"
     "trim_left"
     "trim_prefix"
     "type_name"
     "union"
     "upper"
     "walk"))

(fn_name
  . (var) @_first @module.builtin
  . (var)* @module.builtin
  . (var) @function.builtin
  . (#any-of? @_first
     "array"
     "base64"
     "base64url"
     "bits"
     "crypto"
     "graph"
     "graphql"
     "hex"
     "http"
     "io"
     "json"
     "net"
     "numbers"
     "object"
     "opa"
     "rand"
     "regal"
     "regex"
     "rego"
     "semver"
     "strings"
     "time"
     "units"
     "uri"
     "urlquery"
     "uuid"
     "yaml"))

; The parser doesn't parse `io.jwt.verify_xyz("a", "b")` correctly
(expr
  (expr_infix
    . (expr
        (term
          (ref
            . (var) @_first @module.builtin
            . (ref_arg
                (ref_arg_dot
                  (var) @module.builtin))*
            . (ref_arg
                (ref_arg_dot
                  (var) @function.builtin))
            . )))
    . (infix_operator . (arith_operator) .)
    . (expr
        (expr_parens
          . (open_paren)
          . (expr (term))
          . (ERROR (term)+)?
          . (close_paren)
          . )))
  (#any-of? @_first
     "array"
     "base64"
     "base64url"
     "bits"
     "crypto"
     "graph"
     "graphql"
     "hex"
     "http"
     "io"
     "json"
     "net"
     "numbers"
     "object"
     "opa"
     "rand"
     "regal"
     "regex"
     "rego"
     "semver"
     "strings"
     "time"
     "units"
     "uri"
     "urlquery"
     "uuid"
     "yaml"))

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
((rule
   (rule_head (var) (open_bracket) (term) (close_bracket))
   (rule_body (literal (expr (term (ref (var) @keyword.operator))))))
 . (rule (rule_head (var) (if)))
 (#eq? @keyword.operator "contains"))
