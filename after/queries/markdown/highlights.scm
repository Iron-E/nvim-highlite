;; extends

; inline latex
("$" @conceal
	(#set! conceal "")
	(#set! "priority" 101)
)

; punctuation
((list_marker_dot) @punctuation.delimiter (#offset-from-end! @punctuation.delimiter 0 -2 0 0))

(link_reference_definition ":" @punctuation.delimiter)
(link_reference_definition (link_label) @punctuation.bracket (#offset-from-end! @punctuation.bracket 0 -1 0 0))
(link_reference_definition (link_label) @punctuation.bracket (#offset-from-start! @punctuation.bracket 0 0 0 1))

; BUG: doesn't work because of neovim/neovim#17099
; (pipe_table
; 	(pipe_table_header . "|" "|"* @punctuation.delimiter "|" .)
; 	(pipe_table_delimiter_row . "|" _* @punctuation.delimiter "|" .)
; 	(pipe_table_row . "|" "|"* @punctuation.delimiter "|" .)
; )

; text environments
(fenced_code_block
	(fenced_code_block_delimiter) @text.environment
	(info_string) @text.environment.name
)

; titles
(atx_heading
	[
		((atx_h1_marker) heading_content: (inline) @text.title.h1)
		((atx_h2_marker) heading_content: (inline) @text.title.h2)
		((atx_h3_marker) heading_content: (inline) @text.title.h3)
		((atx_h4_marker) heading_content: (inline) @text.title.h4)
		((atx_h5_marker) heading_content: (inline) @text.title.h5)
		((atx_h6_marker) heading_content: (inline) @text.title.h6)
	]
)
