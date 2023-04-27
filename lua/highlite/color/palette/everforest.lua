--- @type highlite.color.palette.get
local function get(bg, get_terminal)
	local palette, terminal_palette
	if bg ~= 'light' then
		if get_terminal then
			terminal_palette =
			{
				[1] = "#475258",
				[2] = "#E67E80",
				[3] = "#A7C080",
				[4] = "#DBBC7F",
				[5] = "#7FBBB3",
				[6] = "#D699B6",
				[7] = "#83C092",
				[8] = "#D3C6AA",
				[9] = "#475258",
				[10] = "#E67E80",
				[11] = "#A7C080",
				[12] = "#DBBC7F",
				[13] = "#7FBBB3",
				[14] = "#D699B6",
				[15] = "#83C092",
				[16] = "#D3C6AA",
			}
		end

		palette =
		{
			annotation = 0xD699B6,
			attribute = 0xD699B6,
			bg = 0x2D353B,
			bg_contrast_high = 0x4F585E,
			bg_contrast_low = 0x343F44,
			boolean = 0xD699B6,
			buffer_active = 0xD3C6AA,
			buffer_alternate = 0xA7C080,
			buffer_current = 0x543A48,
			character = 0x83C092,
			character_special = 0xDBBC7F,
			class = 0xDBBC7F,
			comment = 0x859289,
			comment_documentation = 0x859289,
			conditional = 0xE67E80,
			constant = 0xD3C6AA,
			constant_builtin = 0xD699B6,
			constructor = 0xA7C080,
			decorator = 0xA7C080,
			define = 0xD699B6,
			diff_add = 0xA7C080,
			diff_change = 0x7FBBB3,
			diff_delete = 0xE67E80,
			enum = 0xDBBC7F,
			error = 0xE67E80,
			event = 0xE67E80,
			field = 0x7FBBB3,
			field_enum = 0x7FBBB3,
			float = 0xD699B6,
			fold = 0x343F44,
			func = 0xA7C080,
			func_builtin = 0xA7C080,
			hint = 0xA7C080,
			identifier = 0x7FBBB3,
			include = 0xE67E80,
			info = 0x7FBBB3,
			interface = 0xDBBC7F,
			keyword = 0xE67E80,
			keyword_coroutine = 0xE67E80,
			keyword_function = 0xE67E80,
			keyword_operator = 0xE69875,
			keyword_return = 0xE67E80,
			label = 0xE69875,
			loop = 0xE67E80,
			macro = 0x83C092,
			message = 0xD3C6AA,
			method = 0xA7C080,
			namespace = 0xDBBC7F,
			number = 0xD699B6,
			ok = 0x90EE90,
			operator = 0xE69875,
			parameter = 0xD3C6AA,
			preproc = 0xD699B6,
			preproc_conditional = 0xD699B6,
			property = 0x7FBBB3,
			punctuation = 0xD3C6AA,
			punctuation_bracket = 0xD3C6AA,
			punctuation_delimiter = 0x859289,
			punctuation_special = 0x7FBBB3,
			search = 0xA7C080,
			select = 0x543A48,
			special = 0xDBBC7F,
			statement = 0xE67E80,
			storage = 0xE69875,
			string = 0x83C092,
			string_escape = 0xDBBC7F,
			string_regex = 0xA7C080,
			string_special = 0xDBBC7F,
			structure = 0xE69875,
			syntax_error = 0xE67E80,
			tag = 0xE69875,
			tag_attribute = 0xA7C080,
			tag_delimiter = 0xA7C080,
			text = 0xD3C6AA,
			text_contrast_bg_high = 0xD3C6AA,
			text_contrast_bg_low = 0x859289,
			text_literal = 0xA7C080,
			text_reference = 0x83C092,
			throw = 0xE67E80,
			todo = 0x7FBBB3,
			type = 0xDBBC7F,
			type_builtin = 0xDBBC7F,
			type_parameter = 0xDBBC7F,
			uri = 0x7FBBB3,
			variable = 0xD3C6AA,
			variable_builtin = 0xD699B6,
			warning = 0xDBBC7F,
		}
	else
		if get_terminal then
			terminal_palette =
			{
				[1] = "#5C6A72",
				[2] = "#F85552",
				[3] = "#8DA101",
				[4] = "#DFA000",
				[5] = "#3A94C5",
				[6] = "#DF69BA",
				[7] = "#35A77C",
				[8] = "#E6E2CC",
				[9] = "#5C6A72",
				[10] = "#F85552",
				[11] = "#8DA101",
				[12] = "#DFA000",
				[13] = "#3A94C5",
				[14] = "#DF69BA",
				[15] = "#35A77C",
				[16] = "#E6E2CC",
			}
		end

		palette =
		{
			annotation = 0xDF69BA,
			attribute = 0xDF69BA,
			bg = 0xFDF6E3,
			bg_contrast_high = 0xE0DCC7,
			bg_contrast_low = 0xF4F0D9,
			boolean = 0xDF69BA,
			buffer_active = 0x5C6A72,
			buffer_alternate = 0x8DA101,
			buffer_current = 0xEAEDC8,
			character = 0x35A77C,
			character_special = 0xDFA000,
			class = 0xDFA000,
			comment = 0x939F91,
			comment_documentation = 0x939F91,
			conditional = 0xF85552,
			constant = 0x5C6A72,
			constant_builtin = 0xDF69BA,
			constructor = 0x8DA101,
			decorator = 0x8DA101,
			define = 0xDF69BA,
			diff_add = 0x8DA101,
			diff_change = 0x3A94C5,
			diff_delete = 0xF85552,
			enum = 0xDFA000,
			error = 0xF85552,
			event = 0xF85552,
			field = 0x3A94C5,
			field_enum = 0x3A94C5,
			float = 0xDF69BA,
			fold = 0xF4F0D9,
			func = 0x8DA101,
			func_builtin = 0x8DA101,
			hint = 0x8DA101,
			identifier = 0x3A94C5,
			include = 0xF85552,
			info = 0x3A94C5,
			interface = 0xDFA000,
			keyword = 0xF85552,
			keyword_coroutine = 0xF85552,
			keyword_function = 0xF85552,
			keyword_operator = 0xF57D26,
			keyword_return = 0xF85552,
			label = 0xF57D26,
			loop = 0xF85552,
			macro = 0x35A77C,
			message = 0x5C6A72,
			method = 0x8DA101,
			namespace = 0xDFA000,
			number = 0xDF69BA,
			ok = 0x90EE90,
			operator = 0xF57D26,
			parameter = 0x5C6A72,
			preproc = 0xDF69BA,
			preproc_conditional = 0xDF69BA,
			property = 0x3A94C5,
			punctuation = 0x5C6A72,
			punctuation_bracket = 0x5C6A72,
			punctuation_delimiter = 0x939F91,
			punctuation_special = 0x3A94C5,
			search = 0x8DA101,
			select = 0xEAEDC8,
			special = 0xDFA000,
			statement = 0xF85552,
			storage = 0xF57D26,
			string = 0x35A77C,
			string_escape = 0xDFA000,
			string_regex = 0x8DA101,
			string_special = 0xDFA000,
			structure = 0xF57D26,
			syntax_error = 0xF85552,
			tag = 0xF57D26,
			tag_attribute = 0x8DA101,
			tag_delimiter = 0x8DA101,
			text = 0x5C6A72,
			text_contrast_bg_high = 0x5C6A72,
			text_contrast_bg_low = 0x939F91,
			text_literal = 0x8DA101,
			text_reference = 0x35A77C,
			throw = 0xF85552,
			todo = 0x3A94C5,
			type = 0xDFA000,
			type_builtin = 0xDFA000,
			type_parameter = 0xDFA000,
			uri = 0x3A94C5,
			variable = 0x5C6A72,
			variable_builtin = 0xDF69BA,
			warning = 0xDFA000,
		}
	end

	return palette, terminal_palette
end

return get