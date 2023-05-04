--- @type highlite.color.palette.get
local function get(bg, get_terminal)
	local palette, terminal_palette
	if bg ~= 'light' then
		if get_terminal then
			terminal_palette =
			{
				[1] = "#5A524C",
				[2] = "#EA6962",
				[3] = "#A9B665",
				[4] = "#D8A657",
				[5] = "#7DAEA3",
				[6] = "#D3869B",
				[7] = "#89B482",
				[8] = "#D4BE98",
				[9] = "#5A524C",
				[10] = "#EA6962",
				[11] = "#A9B665",
				[12] = "#D8A657",
				[13] = "#7DAEA3",
				[14] = "#D3869B",
				[15] = "#89B482",
				[16] = "#D4BE98",
			}
		end

		palette =
		{
			annotation = 0xD3869B,
			attribute = 0xD3869B,
			bg = 0x282828,
			bg_contrast_high = 0x5A524C,
			bg_contrast_low = 0x32302F,
			boolean = 0xD3869B,
			buffer_active = 0xD4BE98,
			buffer_alternate = 0xA9B665,
			buffer_current = 0x45403D,
			character = 0x89B482,
			character_special = 0xD8A657,
			class = 0xD8A657,
			comment = 0x928374,
			comment_documentation = 0x928374,
			conditional = 0xEA6962,
			constant = 0xD4BE98,
			constant_builtin = 0xD3869B,
			constructor = 0xA9B665,
			decorator = 0xA9B665,
			define = 0xD3869B,
			diff_add = 0xA9B665,
			diff_change = 0x7DAEA3,
			diff_delete = 0xEA6962,
			enum = 0xD8A657,
			error = 0xEA6962,
			event = 0xEA6962,
			field = 0x7DAEA3,
			field_enum = 0x7DAEA3,
			float = 0xD3869B,
			fold = 0x32302F,
			func = 0xA9B665,
			func_builtin = 0xA9B665,
			hint = 0xA9B665,
			identifier = 0x7DAEA3,
			include = 0xEA6962,
			info = 0x7DAEA3,
			interface = 0xD8A657,
			keyword = 0xEA6962,
			keyword_coroutine = 0xEA6962,
			keyword_function = 0xEA6962,
			keyword_operator = 0xE78A4E,
			keyword_return = 0xEA6962,
			label = 0xE78A4E,
			loop = 0xEA6962,
			macro = 0x89B482,
			message = 0xD4BE98,
			method = 0xA9B665,
			namespace = 0xD8A657,
			number = 0xD3869B,
			ok = 0x90EE90,
			operator = 0xE78A4E,
			parameter = 0xD4BE98,
			preproc = 0xD3869B,
			preproc_conditional = 0xD3869B,
			property = 0x7DAEA3,
			punctuation = 0xD4BE98,
			punctuation_bracket = 0xD4BE98,
			punctuation_delimiter = 0x928374,
			punctuation_special = 0x7DAEA3,
			search = 0xA9B665,
			select = 0x45403D,
			special = 0xD8A657,
			statement = 0xEA6962,
			storage = 0xE78A4E,
			string = 0x89B482,
			string_escape = 0xA9B665,
			string_regex = 0xA9B665,
			string_special = 0xD8A657,
			structure = 0xE78A4E,
			syntax_error = 0x5D2A27,
			tag = 0xE78A4E,
			tag_attribute = 0xA9B665,
			tag_delimiter = 0xA9B665,
			text = 0xD4BE98,
			text_contrast_bg_high = 0xD4BE98,
			text_contrast_bg_low = 0x928374,
			text_environment = 0x928374,
			text_environment_name = 0xE78A4E,
			text_literal = 0xA9B665,
			text_reference = 0x89B482,
			throw = 0xEA6962,
			todo = 0x7DAEA3,
			type = 0xD8A657,
			type_builtin = 0xD8A657,
			type_parameter = 0xD8A657,
			uri = 0x7DAEA3,
			variable = 0xD4BE98,
			variable_builtin = 0xD3869B,
			warning = 0xD8A657,
		}
	else
		if get_terminal then
			terminal_palette =
			{
				[1] = "#654735",
				[2] = "#C14A4A",
				[3] = "#6C782E",
				[4] = "#B47109",
				[5] = "#45707A",
				[6] = "#945E80",
				[7] = "#4C7A5D",
				[8] = "#DDCCAB",
				[9] = "#654735",
				[10] = "#C14A4A",
				[11] = "#6C782E",
				[12] = "#B47109",
				[13] = "#45707A",
				[14] = "#945E80",
				[15] = "#4C7A5D",
				[16] = "#DDCCAB",
			}
		end

		palette =
		{
			annotation = 0x945E80,
			attribute = 0x945E80,
			bg = 0xFBF1C7,
			bg_contrast_high = 0xDDCCAB,
			bg_contrast_low = 0xF4E8BE,
			boolean = 0x945E80,
			buffer_active = 0x654735,
			buffer_alternate = 0x6F8352,
			buffer_current = 0xEEE0B7,
			character = 0x4C7A5D,
			character_special = 0xB47109,
			class = 0xB47109,
			comment = 0x928374,
			comment_documentation = 0x928374,
			conditional = 0xC14A4A,
			constant = 0x654735,
			constant_builtin = 0x945E80,
			constructor = 0x6C782E,
			decorator = 0x6C782E,
			define = 0x945E80,
			diff_add = 0x6C782E,
			diff_change = 0x45707A,
			diff_delete = 0xC14A4A,
			enum = 0xB47109,
			error = 0xC14A4A,
			event = 0xC14A4A,
			field = 0x45707A,
			field_enum = 0x45707A,
			float = 0x945E80,
			fold = 0xF2E5BC,
			func = 0x6C782E,
			func_builtin = 0x6C782E,
			hint = 0x6C782E,
			identifier = 0x45707A,
			include = 0xC14A4A,
			info = 0x45707A,
			interface = 0xB47109,
			keyword = 0xC14A4A,
			keyword_coroutine = 0xC14A4A,
			keyword_function = 0xC14A4A,
			keyword_operator = 0xC35E0A,
			keyword_return = 0xC14A4A,
			label = 0xC35E0A,
			loop = 0xC14A4A,
			macro = 0x4C7A5D,
			message = 0x654735,
			method = 0x6C782E,
			namespace = 0xB47109,
			number = 0x945E80,
			ok = 0x90EE90,
			operator = 0xC35E0A,
			parameter = 0x654735,
			preproc = 0x945E80,
			preproc_conditional = 0x945E80,
			property = 0x45707A,
			punctuation = 0x654735,
			punctuation_bracket = 0x654735,
			punctuation_delimiter = 0x928374,
			punctuation_special = 0x45707A,
			search = 0x6F8352,
			select = 0xEEE0B7,
			special = 0xB47109,
			statement = 0xC14A4A,
			storage = 0xC35E0A,
			string = 0x4C7A5D,
			string_escape = 0x6C782E,
			string_regex = 0x6C782E,
			string_special = 0xB47109,
			structure = 0xC35E0A,
			syntax_error = 0xFF7D7D,
			tag = 0xC35E0A,
			tag_attribute = 0x6C782E,
			tag_delimiter = 0x6C782E,
			text = 0x654735,
			text_contrast_bg_high = 0x654735,
			text_contrast_bg_low = 0x928374,
			text_environment = 0x928374,
			text_environment_name = 0xC35E0A,
			text_literal = 0x6C782E,
			text_reference = 0x4C7A5D,
			throw = 0xC14A4A,
			todo = 0x45707A,
			type = 0xB47109,
			type_builtin = 0xB47109,
			type_parameter = 0xB47109,
			uri = 0x45707A,
			variable = 0x654735,
			variable_builtin = 0x945E80,
			warning = 0xB47109,
		}
	end

	return palette, terminal_palette
end

return get
