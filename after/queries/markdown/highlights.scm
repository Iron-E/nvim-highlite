;; extends

; punctuation
((list_marker_dot) @punctuation.delimiter (#offset-from! "end" @punctuation.delimiter 0 -2 0 0))

(link_reference_definition ":" @punctuation.delimiter)
(link_reference_definition (link_label) @punctuation.bracket (#offset-from! "end" @punctuation.bracket 0 -1 0 0))
(link_reference_definition (link_label) @punctuation.bracket (#offset-from! "start" @punctuation.bracket 0 0 0 1))

; BUG: doesn't work because of neovim/neovim#17099
; (pipe_table
; 	(pipe_table_header . "|" "|"* @punctuation.delimiter "|" .)
; 	(pipe_table_delimiter_row . "|" _* @punctuation.delimiter "|" .)
; 	(pipe_table_row . "|" "|"* @punctuation.delimiter "|" .)
; )

; text environments
(fenced_code_block (info_string) @text.environment.name)
(fenced_code_block_delimiter) @text.environment

; titles
(atx_heading
	[
		(atx_h1_marker)
		(atx_h2_marker)
		(atx_h3_marker)
		(atx_h4_marker)
		(atx_h5_marker)
		(atx_h6_marker)
	] @punctuation.special
)
