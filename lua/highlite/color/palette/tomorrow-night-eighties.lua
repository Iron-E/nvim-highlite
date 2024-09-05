--- @type highlite.color.palette.get
local function get(bg, get_terminal)
	local palette, terminal_palette
	fg     = 0xCCCCCC
	hi     = 0xD3D3D3
	bg0    = 0x2D2D2D
	bg1    = 0x393939
	bg2    = 0x515151
	gray   = 0x999999
	red    = 0xF77476
	red_hi = 0xF72f31
	orange = 0xF99157
	yellow = 0xFFCC66
	green  = 0x99CC99
	aqua   = 0x66CCCC
	blue   = 0x6699CC
	purple = 0xCC99CC

	if bg ~= 'light' then
		if get_terminal then
			terminal_palette =
			{
				[1] = "",
				[2] = "",
				[3] = "",
				[4] = "",
				[5] = "",
				[6] = "",
				[7] = "",
				[8] = "",
				[9] = "",
				[10] = "",
				[11] = "",
				[12] = "",
				[13] = "",
				[14] = "",
				[15] = "",
				[16] = "",
			}
		end

		palette =
		{
			annotation            = purple,
			attribute             = purple,
			bg                    = bg0,
			bg_contrast_high      = bg2,
			bg_contrast_low       = bg1,
			boolean               = orange,
			buffer_active         = fg,
			buffer_alternate      = yellow,
			buffer_current        = bg2,
			character             = orange,
			character_special     = fg,
			class                 = purple,
			comment               = gray,
			comment_documentation = gray,
			conditional           = purple,
			constant              = orange,
			constant_builtin      = fg,
			constructor           = green,
			decorator             = blue,
			define                = purple,
			diff_add              = green,
			diff_change           = blue,
			diff_delete           = red,
			enum                  = purple,
			error                 = red_hi,
			event                 = fg,
			field                 = red,
			field_enum            = orange,
			float                 = orange,
			fold                  = bg0,
			func                  = blue,
			func_builtin          = aqua,
			hint                  = hi,
			identifier            = red,
			include               = blue,
			info                  = hi,
			interface             = purple,
			keyword               = orange,
			keyword_coroutine     = orange,
			keyword_function      = orange,
			keyword_operator      = orange,
			keyword_return        = orange,
			label                 = fg,
			loop                  = purple,
			macro                 = purple,
			message               = green,
			method                = blue,
			namespace             = green,
			number                = orange,
			ok                    = green,
			operator              = aqua,
			parameter             = orange,
			preproc               = purple,
			preproc_conditional   = purple,
			property              = red,
			punctuation           = fg,
			punctuation_bracket   = fg,
			punctuation_delimiter = fg,
			punctuation_special   = fg,
			search                = yellow,
			select                = bg2,
			special               = fg,
			statement             = fg,
			storage               = blue,
			string                = green,
			string_escape         = fg,
			string_regex          = green,
			string_special        = fg,
			structure             = purple,
			syntax_error          = red_hi,
			tag                   = fg,
			tag_attribute         = fg,
			tag_delimiter         = fg,
			text                  = fg,
			text_contrast_bg_high = fg,
			text_contrast_bg_low  = gray,
			text_environment      = gray,
			text_environment_name = fg,
			text_literal          = gray,
			text_math             = orange,
			text_reference        = red,
			throw                 = fg,
			todo                  = bg0,
			type                  = blue,
			type_builtin          = blue,
			type_parameter        = blue,
			uri                   = yellow,
			variable              = fg,
			variable_builtin      = fg,
			warning               = yellow,
		}
	else
		if get_terminal then
			terminal_palette =
			{
				[1] = "",
				[2] = "",
				[3] = "",
				[4] = "",
				[5] = "",
				[6] = "",
				[7] = "",
				[8] = "",
				[9] = "",
				[10] = "",
				[11] = "",
				[12] = "",
				[13] = "",
				[14] = "",
				[15] = "",
				[16] = "",
			}
		end

		palette =
		{
			annotation            = purple,
			attribute             = purple,
			bg                    = bg0,
			bg_contrast_high      = bg2,
			bg_contrast_low       = bg1,
			boolean               = orange,
			buffer_active         = fg,
			buffer_alternate      = yellow,
			buffer_current        = bg2,
			character             = orange,
			character_special     = fg,
			class                 = purple,
			comment               = gray,
			comment_documentation = gray,
			conditional           = purple,
			constant              = orange,
			constant_builtin      = fg,
			constructor           = green,
			decorator             = blue,
			define                = purple,
			diff_add              = green,
			diff_change           = blue,
			diff_delete           = red,
			enum                  = purple,
			error                 = red_hi,
			event                 = fg,
			field                 = red,
			field_enum            = orange,
			float                 = orange,
			fold                  = bg0,
			func                  = blue,
			func_builtin          = aqua,
			hint                  = hi,
			identifier            = red,
			include               = blue,
			info                  = hi,
			interface             = purple,
			keyword               = orange,
			keyword_coroutine     = orange,
			keyword_function      = orange,
			keyword_operator      = orange,
			keyword_return        = orange,
			label                 = fg,
			loop                  = purple,
			macro                 = purple,
			message               = green,
			method                = blue,
			namespace             = green,
			number                = orange,
			ok                    = green,
			operator              = aqua,
			parameter             = orange,
			preproc               = purple,
			preproc_conditional   = purple,
			property              = red,
			punctuation           = fg,
			punctuation_bracket   = fg,
			punctuation_delimiter = fg,
			punctuation_special   = fg,
			search                = yellow,
			select                = bg2,
			special               = fg,
			statement             = fg,
			storage               = blue,
			string                = green,
			string_escape         = fg,
			string_regex          = green,
			string_special        = fg,
			structure             = purple,
			syntax_error          = red_hi,
			tag                   = fg,
			tag_attribute         = fg,
			tag_delimiter         = fg,
			text                  = fg,
			text_contrast_bg_high = fg,
			text_contrast_bg_low  = gray,
			text_environment      = gray,
			text_environment_name = fg,
			text_literal          = gray,
			text_math             = orange,
			text_reference        = red,
			throw                 = fg,
			todo                  = bg0,
			type                  = blue,
			type_builtin          = blue,
			type_parameter        = blue,
			uri                   = yellow,
			variable              = fg,
			variable_builtin      = fg,
			warning               = yellow,
		}
	end

	return palette, terminal_palette
end

return get
