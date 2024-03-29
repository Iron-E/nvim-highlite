--- @type highlite.color.palette.get
local function get(bg, get_terminal)
	local palette, terminal_palette
	if bg ~= 'light' then
		if get_terminal then
			terminal_palette =
			{
				[1] = "#1C1C1C",
				[2] = "#AF005F",
				[3] = "#5FAF00",
				[4] = "#D7AF5F",
				[5] = "#5FAFD7",
				[6] = "#808080",
				[7] = "#D7875F",
				[8] = "#D0D0D0",
				[9] = "#585858",
				[10] = "#5FAF5F",
				[11] = "#AFD700",
				[12] = "#AF87D7",
				[13] = "#FFAF00",
				[14] = "#FF5FAF",
				[15] = "#00AFAF",
				[16] = "#5F8787",
			}
		end

		palette =
		{
			annotation = 0x00AFAF,
			attribute = 0x00AFAF,
			bg = 0x1C1C1C,
			bg_contrast_high = 0x585858,
			bg_contrast_low = 0x303030,
			boolean = 0xD7AF00,
			buffer_active = 0x5FAFD7,
			buffer_alternate = 0x00875F,
			buffer_current = 0x8787AF,
			character = 0xD7AF5F,
			character_special = 0xD0D0D0,
			class = 0x00AFAF,
			comment = 0x808080,
			comment_documentation = 0x808080,
			conditional = 0xAF87D7,
			constant = 0xFF5FAF,
			constant_builtin = 0xD0D0D0,
			constructor = 0xD0D0D0,
			decorator = 0xD0D0D0,
			define = 0x00AFAF,
			diff_add = 0x87D700,
			diff_change = 0xD0D0D0,
			diff_delete = 0xAF005F,
			enum = 0x00AFAF,
			error = 0xAF005F,
			event = 0xAF87D7,
			field = 0xD7875F,
			field_enum = 0xFF5FAF,
			float = 0xFF5FAF,
			fold = 0x5F005F,
			func = 0xD0D0D0,
			func_builtin = 0xD0D0D0,
			hint = 0xFF8700,
			identifier = 0xD7875F,
			include = 0x5FAF5F,
			info = 0xFF8700,
			interface = 0x00AFAF,
			keyword = 0x00AFAF,
			keyword_coroutine = 0x00AFAF,
			keyword_function = 0x00AFAF,
			keyword_operator = 0x00AFAF,
			keyword_return = 0x00AFAF,
			label = 0x00AFAF,
			loop = 0xAF87D7,
			macro = 0x00AFAF,
			message = 0xD7AF5F,
			method = 0xD0D0D0,
			namespace = 0xD7875F,
			number = 0xFF5FAF,
			ok = 0x90EE90,
			operator = 0x5FAFD7,
			parameter = 0xD7875F,
			preproc = 0x00AFAF,
			preproc_conditional = 0x5FAFD7,
			property = 0xD7875F,
			punctuation = 0x5FAFD7,
			punctuation_bracket = 0x5FAFD7,
			punctuation_delimiter = 0x5FAFD7,
			punctuation_special = 0x5FAFD7,
			search = 0x00875F,
			select = 0x8787AF,
			special = 0xD0D0D0,
			statement = 0xAFD700,
			storage = 0xD7875F,
			string = 0xD7AF5F,
			string_escape = 0xD0D0D0,
			string_regex = 0xD7AF5F,
			string_special = 0xD0D0D0,
			structure = 0x00AFAF,
			syntax_error = 0x7F0000,
			tag = 0xD7AF00,
			tag_attribute = 0xD7AF00,
			tag_delimiter = 0xD7AF00,
			text = 0xD0D0D0,
			text_contrast_bg_high = 0x5FAFD7,
			text_contrast_bg_low = 0x808080,
			text_environment = 0x808080,
			text_environment_name = 0x00AFAF,
			text_literal = 0x808080,
			text_math = 0xFF5FAF,
			text_reference = 0xD7875F,
			throw = 0x5FAF5F,
			todo = 0x1C1C1C,
			type = 0xAFD700,
			type_builtin = 0xAFD700,
			type_parameter = 0xAFD700,
			uri = 0x80A0FF,
			variable = 0xD7875F,
			variable_builtin = 0xD7875F,
			warning = 0xFF8700,
		}
	else
		if get_terminal then
			terminal_palette =
			{
				[1] = "#EEEEEE",
				[2] = "#AF0000",
				[3] = "#008700",
				[4] = "#5F8700",
				[5] = "#0087AF",
				[6] = "#878787",
				[7] = "#005F87",
				[8] = "#444444",
				[9] = "#BCBCBC",
				[10] = "#D70000",
				[11] = "#D70087",
				[12] = "#8700AF",
				[13] = "#D75F00",
				[14] = "#D75F00",
				[15] = "#005FAF",
				[16] = "#005F87",
			}
		end

		palette =
		{
			annotation = 0x005FAF,
			attribute = 0x005FAF,
			bg = 0xEEEEEE,
			bg_contrast_high = 0xBCBCBC,
			bg_contrast_low = 0xE4E4E4,
			boolean = 0x008700,
			buffer_active = 0x0087AF,
			buffer_alternate = 0xFFFF5F,
			buffer_current = 0x0087AF,
			character = 0x5F8700,
			character_special = 0x444444,
			class = 0x005FAF,
			comment = 0x878787,
			comment_documentation = 0x878787,
			conditional = 0x8700AF,
			constant = 0xD75F00,
			constant_builtin = 0x444444,
			constructor = 0x444444,
			decorator = 0x444444,
			define = 0x005FAF,
			diff_add = 0x008700,
			diff_change = 0x444444,
			diff_delete = 0xAF0000,
			enum = 0x005FAF,
			error = 0xAF0000,
			event = 0x8700AF,
			field = 0x005F87,
			field_enum = 0xD75F00,
			float = 0xD75F00,
			fold = 0xAFD7FF,
			func = 0x444444,
			func_builtin = 0x444444,
			hint = 0x00AF5F,
			identifier = 0x005F87,
			include = 0xD70000,
			info = 0x00AF5F,
			interface = 0x005FAF,
			keyword = 0x005FAF,
			keyword_coroutine = 0x005FAF,
			keyword_function = 0x005FAF,
			keyword_operator = 0x005FAF,
			keyword_return = 0x005FAF,
			label = 0x005FAF,
			loop = 0x8700AF,
			macro = 0x005FAF,
			message = 0x5F8700,
			method = 0x444444,
			namespace = 0x005F87,
			number = 0xD75F00,
			ok = 0x90EE90,
			operator = 0x0087AF,
			parameter = 0x005F87,
			preproc = 0x005FAF,
			preproc_conditional = 0x0087AF,
			property = 0x005F87,
			punctuation = 0x0087AF,
			punctuation_bracket = 0x0087AF,
			punctuation_delimiter = 0x0087AF,
			punctuation_special = 0x0087AF,
			search = 0xFFFF5F,
			select = 0x0087AF,
			special = 0x444444,
			statement = 0xD70087,
			storage = 0x005F87,
			string = 0x5F8700,
			string_escape = 0x444444,
			string_regex = 0x5F8700,
			string_special = 0x444444,
			structure = 0x005FAF,
			syntax_error = 0xFFD7FF,
			tag = 0x008700,
			tag_attribute = 0x008700,
			tag_delimiter = 0x008700,
			text = 0x444444,
			text_contrast_bg_high = 0x0087AF,
			text_contrast_bg_low = 0x878787,
			text_environment = 0x878787,
			text_environment_name = 0x005FAF,
			text_literal = 0x878787,
			text_math = 0xD75F00,
			text_reference = 0x005F87,
			throw = 0xD70000,
			todo = 0xEEEEEE,
			type = 0xD70087,
			type_builtin = 0xD70087,
			type_parameter = 0xD70087,
			uri = 0x6A5ACD,
			variable = 0x005F87,
			variable_builtin = 0x005F87,
			warning = 0x00AF5F,
		}
	end

	return palette, terminal_palette
end

return get
