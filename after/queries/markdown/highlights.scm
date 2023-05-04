;; extends

; inline latex
("$" @conceal
	(#set! conceal "")
	(#set! "priority" 101)
)

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
