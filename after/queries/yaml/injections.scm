;; extends

; github-script, e.g.
;
; ```yaml
; - uses: actions/github-script
;   with:
;     script: |
;       console.log()
; ```

(block_mapping
  (block_mapping_pair
    key: (flow_node [
      (double_quote_scalar)
      (single_quote_scalar)
      (plain_scalar (string_scalar))
    ] @_uses)
    (#lua-match? @_uses "^[\"']?uses[\"']?$")

    value: [
      (block_node (block_scalar))
      (flow_node [
        (double_quote_scalar)
        (single_quote_scalar)
        (plain_scalar (string_scalar))
      ])
    ] @_action
    (#contains? @_action "actions/github-script")
  )

  (block_mapping_pair
    key: (flow_node [
      (double_quote_scalar)
      (single_quote_scalar)
      (plain_scalar (string_scalar))
    ] @_with)
    (#lua-match? @_with "^[\"']?with[\"']?$")

    value: (block_node
      (block_mapping
        (block_mapping_pair
          key: (flow_node [
            (double_quote_scalar)
            (single_quote_scalar)
            (plain_scalar (string_scalar))
          ] @_script)
          (#lua-match? @_script "^[\"']?script[\"']?$")

          value: (block_node (block_scalar) @injection.content)
          (#offset! @injection.content 0 1 0 0)
          (#set! injection.language "javascript")
          (#set! priority 105)
        )
      )
    )
  )
)

; github-script, e.g.
;
; ```yaml
; - uses: actions/github-script
;   with:
;     script: "console.log()"
; ```

(block_mapping
  (block_mapping_pair
    key: (flow_node [
      (double_quote_scalar)
      (single_quote_scalar)
      (plain_scalar (string_scalar))
    ] @_uses)
    (#lua-match? @_uses "^[\"']?uses[\"']?$")

    value: [
      (block_node (block_scalar))
      (flow_node [
        (double_quote_scalar)
        (single_quote_scalar)
        (plain_scalar (string_scalar))
      ])
    ] @_action
    (#contains? @_action "actions/github-script")
  )

  (block_mapping_pair
    key: (flow_node [
      (double_quote_scalar)
      (single_quote_scalar)
      (plain_scalar (string_scalar))
    ] @_with)
    (#lua-match? @_with "^[\"']?with[\"']?$")

    value: (block_node
      (block_mapping
        (block_mapping_pair
          key: (flow_node [
            (double_quote_scalar)
            (single_quote_scalar)
            (plain_scalar (string_scalar))
          ] @_script)
          (#lua-match? @_script "^[\"']?script[\"']?$")

          value: (flow_node [
            (double_quote_scalar)
            (single_quote_scalar)
          ] @injection.content)

          (#offset! @injection.content 0 1 0 -1)
          (#set! injection.language "javascript")
          (#set! priority 105)
        )
      )
    )
  )
)

; github-script, e.g.
;
; ```yaml
; - uses: actions/github-script
;   with:
;     script: console.log()
; ```

(block_mapping
  (block_mapping_pair
    key: (flow_node [
      (double_quote_scalar)
      (single_quote_scalar)
      (plain_scalar (string_scalar))
    ] @_uses)
    (#lua-match? @_uses "^[\"']?uses[\"']?$")

    value: [
      (block_node (block_scalar))
      (flow_node [
        (double_quote_scalar)
        (single_quote_scalar)
        (plain_scalar (string_scalar))
      ])
    ] @_action
    (#contains? @_action "actions/github-script")
  )

  (block_mapping_pair
    key: (flow_node [
      (double_quote_scalar)
      (single_quote_scalar)
      (plain_scalar (string_scalar))
    ] @_with)
    (#lua-match? @_with "^[\"']?with[\"']?$")

    value: (block_node
      (block_mapping
        (block_mapping_pair
          key: (flow_node [
            (double_quote_scalar)
            (single_quote_scalar)
            (plain_scalar (string_scalar))
          ] @_script)
          (#lua-match? @_script "^[\"']?script[\"']?$")

          value: (flow_node (plain_scalar (string_scalar) @injection.content))

          (#set! injection.language "javascript")
          (#set! priority 105)
        )
      )
    )
  )
)
