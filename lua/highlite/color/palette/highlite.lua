--- @type highlite.color.palette.get
local function get(bg, get_terminal)
	local palette, terminal_palette
	if bg ~= 'light' then
		local black       = 0x202020
		local gray        = 0x808080
		local gray_dark   = 0x505050
		local gray_darker = 0x353535
		local gray_light  = 0xC0C0C0
		local white       = 0xFFFFFF

		local red       = 0xEE4A59
		local red_dark  = 0xA80000
		local red_light = 0xFF4090

		local orange       = 0xFF8900
		local orange_light = 0xF0AF00

		local tan = 0xF4C069
		local yellow = 0xF0DF33

		local green_dark  = 0x70D533
		local green       = 0x22FF22
		local green_light = 0x99FF99
		local turqoise    = 0x2BFF99

		local blue = 0x7766FF
		local cyan = 0x33DBC3
		local ice  = 0x95C5FF
		local navy = 0x264F60
		local teal = 0x60AFFF

		local magenta_light = 0xD5508F
		local magenta       = 0xDF50B0
		local pink          = 0xFFA6FF
		local pink_light    = 0xFFB7B7
		local purple        = 0xCF55F0
		local purple_light  = 0xAF60AF

		if get_terminal then
			terminal_palette =
			{
				'#202020', '#A80000', '#70D533', '#FF8900', '#7766FF', '#DF50B0', '#60AFFF', '#C0C0C0',
				'#353535', '#EE4A59', '#22FF22', '#F0DF33', '#2BFF99', '#CF55F0', '#33DBC3', '#FFFFFF',
			}
		end

		palette =
		{
			bg = black,
			bg_contrast_high = gray_dark,
			bg_contrast_low = gray_darker,

			text = gray_light,
			text_contrast_bg_high = white,
			text_contrast_bg_low = gray,

			boolean = yellow,
			buffer_active = white,
			buffer_alternate = magenta_light,
			buffer_current = teal,
			character = red_light,
			conditional = ice,
			constant = orange_light,
			define = blue,
			diff_add = green,
			diff_change = yellow,
			diff_delete = red,
			error = red,
			fold = purple_light,
			func = purple,
			hint = magenta_light,
			identifier = gray_light,
			include = green_light,
			info = pink_light,
			keyword = teal,
			label = pink,
			loop = turqoise,
			message = orange_light,
			namespace = ice,
			number = pink_light,
			ok = green,
			operator = green,
			preproc = tan,
			search = green_light,
			select = navy,
			special = magenta,
			statement = ice,
			storage = orange_light,
			string = green_dark,
			structure = blue,
			syntax_error = red_dark,
			throw = red_light,
			todo = cyan,
			type = cyan,
			uri = turqoise,
			warning = orange,
		}
	else
		local black       = 0x000000
		local gray        = 0xA0A0A0
		local gray_dark   = 0x6E6E6E
		local gray_darker = 0x343434
		local gray_light  = 0xBEBEBE
		local white       = 0xD7D7D7

		local red = 0xB7002F
		local red_dark = 0x4A1318
		local red_light = 0xAF005A

		local brown = 0x6A4900
		local orange = 0x964E00
		local orange_dark = 0x855F00
		local salmon = 0xF65F4E

		local yellow = 0x706700

		local green = 0x007743
		local green_dark = 0x00510B
		local green_desaturated = 0x347700
		local green_saturated = 0x007A01

		local blue = 0x005090
		local blue_dark = 0x033362
		local cyan = 0x007768
		local ice = 0x84AFC2
		local ultra_violet = 0x614AE2

		local pink = 0xA4077C
		local pink_light = 0xAD296D
		local purple = 0x8E01AB
		local purple_dark = 0x520055
		local purple_light = 0x964896

		if get_terminal then
			terminal_palette =
			{
				'#000000', '#4A1318', '#00510B', '#964E00', '#033362', '#8E01AB', '#007768', '#BEBEBE',
				'#343434', '#B7002F', '#007743', '#706700', '#005090', '#964896', '#84AFC2', '#D7D7D7',
			}
		end

		palette =
		{
			bg = white,
			bg_contrast_high = gray,
			bg_contrast_low = gray_light,

			text = gray_darker,
			text_contrast_bg_high = black,
			text_contrast_bg_low = gray_dark,

			boolean = yellow,
			buffer_active = black,
			buffer_alternate = pink_light,
			buffer_current = blue,
			character = red_light,
			conditional = blue_dark,
			constant = orange_dark,
			define = ultra_violet,
			diff_add = green_saturated,
			diff_change = yellow,
			diff_delete = red,
			error = red,
			fold = purple_light,
			func = purple,
			hint = pink_light,
			identifier = gray_darker,
			include = green_dark,
			info = red_dark,
			keyword = blue,
			label = purple_dark,
			loop = green,
			message = orange_dark,
			namespace = blue_dark,
			number = red_dark,
			ok = green_saturated,
			operator = green_saturated,
			preproc = brown,
			search = green_dark,
			select = ice,
			special = pink,
			statement = blue_dark,
			storage = orange_dark,
			string = green_desaturated,
			structure = ultra_violet,
			syntax_error = salmon,
			throw = red_light,
			todo = cyan,
			type = cyan,
			uri = green,
			warning = orange,
		}
	end

	return palette, terminal_palette
end

return get
