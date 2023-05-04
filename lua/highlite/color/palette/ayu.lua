--- @type highlite.color.palette.get
local function get(bg, get_terminal)
	local palette, terminal_palette
	if bg ~= 'light' then
		if get_terminal then
			terminal_palette =
			{
				[1] = "#0F1419",
				[2] = "#F07178",
				[3] = "#B8CC52",
				[4] = "#F29718",
				[5] = "#36A3D9",
				[6] = "#FFEE99",
				[7] = "#95E6CB",
				[8] = "#FFFFFF",
				[9] = "#3E4B59",
				[10] = "#FF3333",
				[11] = "#B8CC52",
				[12] = "#F29718",
				[13] = "#36A3D9",
				[14] = "#FFEE99",
				[15] = "#95E6CB",
				[16] = "#5C6773",
			}
		end

		palette =
		{
			annotation = 0xE6B673,
			attribute = 0xE6B673,
			bg = 0x0F1419,
			bg_contrast_high = 0x2D3640,
			bg_contrast_low = 0x151A1E,
			boolean = 0xFFEE99,
			buffer_active = 0xE6B673,
			buffer_alternate = 0xFFEE99,
			buffer_current = 0x253340,
			character = 0xFFEE99,
			character_special = 0xE6B673,
			class = 0xE6B673,
			comment = 0x5C6773,
			comment_documentation = 0x5C6773,
			conditional = 0xFF7733,
			constant = 0xFFEE99,
			constant_builtin = 0xE6B673,
			constructor = 0xE6B673,
			decorator = 0xFFB454,
			define = 0xE6B673,
			diff_add = 0xB8CC52,
			diff_change = 0x36A3D9,
			diff_delete = 0xF07178,
			enum = 0xE6B673,
			error = 0xFF0000,
			event = 0xFF7733,
			field = 0x36A3D9,
			field_enum = 0xFFEE99,
			float = 0xFFEE99,
			fold = 0x14191F,
			func = 0xFFB454,
			func_builtin = 0xE6B673,
			hint = 0xD3D3D3,
			identifier = 0x36A3D9,
			include = 0xE6B673,
			info = 0xADD8E6,
			interface = 0xE6B673,
			keyword = 0xFF7733,
			keyword_coroutine = 0xFF7733,
			keyword_function = 0xFF7733,
			keyword_operator = 0xFF7733,
			keyword_return = 0xFF7733,
			label = 0xFF7733,
			loop = 0xFF7733,
			macro = 0xE6B673,
			message = 0xB8CC52,
			method = 0xFFB454,
			namespace = 0x36A3D9,
			number = 0xFFEE99,
			ok = 0x90EE90,
			operator = 0xE7C547,
			parameter = 0x36A3D9,
			preproc = 0xE6B673,
			preproc_conditional = 0xE6B673,
			property = 0x36A3D9,
			punctuation = 0xE6B673,
			punctuation_bracket = 0xE6B673,
			punctuation_delimiter = 0xE6B673,
			punctuation_special = 0xE6B673,
			search = 0xFFEE99,
			select = 0x253340,
			special = 0xE6B673,
			statement = 0xFF7733,
			storage = 0x36A3D9,
			string = 0xB8CC52,
			string_escape = 0xE6B673,
			string_regex = 0xB8CC52,
			string_special = 0xE6B673,
			structure = 0xE6B673,
			syntax_error = 0x661414,
			tag = 0xE6B673,
			tag_attribute = 0xE6B673,
			tag_delimiter = 0xE6B673,
			text = 0xE6E1CF,
			text_contrast_bg_high = 0xE6B673,
			text_contrast_bg_low = 0x5C6773,
			text_environment = 0x5C6773,
			text_environment_name = 0xFF7733,
			text_literal = 0x5C6773,
			text_reference = 0x36A3D9,
			throw = 0xFF7733,
			todo = 0xF07178,
			type = 0x36A3D9,
			type_builtin = 0x36A3D9,
			type_parameter = 0x36A3D9,
			uri = 0x36A3D9,
			variable = 0x36A3D9,
			variable_builtin = 0x36A3D9,
			warning = 0xFFA500,
		}
	else
		if get_terminal then
			terminal_palette =
			{
				[1] = "#0F1419",
				[2] = "#F07178",
				[3] = "#B8CC52",
				[4] = "#F29718",
				[5] = "#36A3D9",
				[6] = "#FFEE99",
				[7] = "#95E6CB",
				[8] = "#FFFFFF",
				[9] = "#3E4B59",
				[10] = "#FF3333",
				[11] = "#B8CC52",
				[12] = "#F29718",
				[13] = "#36A3D9",
				[14] = "#FFEE99",
				[15] = "#95E6CB",
				[16] = "#5C6773",
			}
		end

		palette =
		{
			annotation = 0xE6B673,
			attribute = 0xE6B673,
			bg = 0x0F1419,
			bg_contrast_high = 0x2D3640,
			bg_contrast_low = 0x151A1E,
			boolean = 0xFFEE99,
			buffer_active = 0xE6B673,
			buffer_alternate = 0xFFEE99,
			buffer_current = 0x253340,
			character = 0xFFEE99,
			character_special = 0xE6B673,
			class = 0xE6B673,
			comment = 0x5C6773,
			comment_documentation = 0x5C6773,
			conditional = 0xFF7733,
			constant = 0xFFEE99,
			constant_builtin = 0xE6B673,
			constructor = 0xE6B673,
			decorator = 0xFFB454,
			define = 0xE6B673,
			diff_add = 0xB8CC52,
			diff_change = 0x36A3D9,
			diff_delete = 0xF07178,
			enum = 0xE6B673,
			error = 0xFF0000,
			event = 0xFF7733,
			field = 0x36A3D9,
			field_enum = 0xFFEE99,
			float = 0xFFEE99,
			fold = 0x14191F,
			func = 0xFFB454,
			func_builtin = 0xE6B673,
			hint = 0xD3D3D3,
			identifier = 0x36A3D9,
			include = 0xE6B673,
			info = 0xADD8E6,
			interface = 0xE6B673,
			keyword = 0xFF7733,
			keyword_coroutine = 0xFF7733,
			keyword_function = 0xFF7733,
			keyword_operator = 0xFF7733,
			keyword_return = 0xFF7733,
			label = 0xFF7733,
			loop = 0xFF7733,
			macro = 0xE6B673,
			message = 0xB8CC52,
			method = 0xFFB454,
			namespace = 0x36A3D9,
			number = 0xFFEE99,
			ok = 0x90EE90,
			operator = 0xE7C547,
			parameter = 0x36A3D9,
			preproc = 0xE6B673,
			preproc_conditional = 0xE6B673,
			property = 0x36A3D9,
			punctuation = 0xE6B673,
			punctuation_bracket = 0xE6B673,
			punctuation_delimiter = 0xE6B673,
			punctuation_special = 0xE6B673,
			search = 0xFFEE99,
			select = 0x253340,
			special = 0xE6B673,
			statement = 0xFF7733,
			storage = 0x36A3D9,
			string = 0xB8CC52,
			string_escape = 0xE6B673,
			string_regex = 0xB8CC52,
			string_special = 0xE6B673,
			structure = 0xE6B673,
			syntax_error = 0x661414,
			tag = 0xE6B673,
			tag_attribute = 0xE6B673,
			tag_delimiter = 0xE6B673,
			text = 0xE6E1CF,
			text_contrast_bg_high = 0xE6B673,
			text_contrast_bg_low = 0x5C6773,
			text_environment = 0x5C6773,
			text_environment_name = 0xFF7733,
			text_literal = 0x5C6773,
			text_reference = 0x36A3D9,
			throw = 0xFF7733,
			todo = 0xF07178,
			type = 0x36A3D9,
			type_builtin = 0x36A3D9,
			type_parameter = 0x36A3D9,
			uri = 0x36A3D9,
			variable = 0x36A3D9,
			variable_builtin = 0x36A3D9,
			warning = 0xFFA500,
		}
	end

	return palette, terminal_palette
end

return get
