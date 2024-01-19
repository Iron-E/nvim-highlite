;; extends

; classes as classes
(class_name) @lsp.type.class

; ids as labels
(id_name) @label

; browser-specific stuff as preproc/macro
((plain_value) @macro (#lua-match? @macro "^%-"))
((property_name) @keyword.directive (#lua-match? @keyword.directive "^%-"))

; tagnames as builtin type
(tag_name) @type.builtin
