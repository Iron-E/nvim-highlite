;; extends

; highlight events as events
(au_event) @event

; highlight keywords as keywords
((augroup_name) @keyword (#lua-match? @keyword "[Ee][Nn][Dd]"))
