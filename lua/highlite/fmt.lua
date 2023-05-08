--- @class highlite.Fmt
local Fmt = {}

do
	--- @alias highlite.Fmt.string.substitution nil|boolean|integer|string

	--- @class highlite.Fmt.string.opts
	--- @field convert_int_attributes? false|'hex_literal'|'hex_string' if `Foo.bar` is an integer (e.g. when `Normal.fg == 16777215`), convert it to a hex string (e.g. `'#FFFFFF'`) or a hex literal (e.g. `0xFFFFFF`)
	--- @field default? true|{[string]: highlite.Fmt.string.substitution} if `true`, use default values when formatting returns `nil` for a highlight group
	--- @field loadstring_compat? boolean if `true`, enable compatability for `loadstring`ing the returned value
	--- @field map? {[string]: nil|fun(value: boolean|integer|string): highlite.Fmt.string.substitution}
	local FMT_STRING_DEFUALT_OPTS =
	{
		convert_int_attributes = 'hex_string',
		default = true,
		map = {},
	}

	--- The pattern which is used to find and replace palette strings.
	local FMT_STRING_PATTERN = '$%b{}'

	--- The defaults used for hl attributes if they are not found during formatting
	local FMT_STRING_DEFAULT_SUBSTITUTIONS =
	{
		bg = 'none', fg = 'none', sp = 'none',
		blend = 0,
		bold = false, italic = false,
		default = false,
		nocombine = false,
		reverse = false, standout = false,
		strikethrough = false,
		undercurl = false, underdashed = false, underdotted = false, underdouble = false, underline = false,
	}

	--- The message when a `vim.validate` fails for an attribute
	local VALIDATE_ATTRIBUTE_MSG = table.concat(vim.tbl_keys(FMT_STRING_DEFAULT_SUBSTITUTIONS), '|')

	--- Gets `"foobar"` from `"${foobar}"`
	--- @param match string
	--- @return string stripped
	local function fmt_string_strip_delim(match)
		return match:sub(3, -2)
	end

	--- Validate that an attribute is one of the expected values
	--- @param attribute? string
	--- @return boolean is_valid
	local function validate_attribute(attribute)
		return FMT_STRING_DEFAULT_SUBSTITUTIONS[attribute] ~= nil
	end

	--- Validate that an attribute is one of the expected values
	--- @param idx? number
	--- @return boolean is_valid
	local function validate_terminal(idx)
		return idx ~= nil and math.floor(idx) == idx and idx > 0 and idx < 17
	end

	--- @param cb fun(s: integer): string
	--- @return fun(definition: table, attribute: string): highlite.Fmt.string.substitution
	local function wrap(cb)
		return function(definition, attribute)
			local substitution = definition[attribute]
			if attribute ~= 'blend' and type(substitution) == 'number' then
				substitution = cb(substitution)
			end

			return substitution
		end
	end

	--- Example:
	---
	--- ```lua
	--- fmt([[normal_fg = ${Normal.fg}; terminal_palette = ${16}]], {bg = 0x202020}, {[16] = '#FFFFFF'})
	--- ```
	---
	--- @param format string
	--- @param opts? highlite.Fmt.string.opts
	--- @return string formatted, integer count
	function Fmt.string(format, opts)
		if opts == nil then
			opts = FMT_STRING_DEFUALT_OPTS
		else
			opts = vim.tbl_extend('keep', opts, FMT_STRING_DEFUALT_OPTS)
		end

		--- Cache of `get_hl`s
		local hl_cache = {}

		local left_delim, right_delim = unpack(opts.loadstring_compat and {[['"]], [["']]} or {'"', '"'})

		local fmt_attribute --- @type fun(definition: table, attribute: string): nil|integer|string
		if opts.convert_int_attributes == 'hex_literal' then
			local l, r = unpack(opts.loadstring_compat and {'"', '"'} or {'', ''})
			fmt_attribute = wrap(function(s) return l .. '0x' .. bit.tohex(s, 6):upper() .. r end)
		elseif opts.convert_int_attributes == 'hex_string' then
			fmt_attribute = wrap(function(s) return left_delim .. '#' .. bit.tohex(s, 6):upper() .. right_delim end)
		else
			--- @param definition table
			--- @param attribute string
			--- @return highlite.Fmt.string.substitution
			function fmt_attribute(definition, attribute) return definition[attribute] end
		end

		return format:gsub(FMT_STRING_PATTERN, function(match)
			match = fmt_string_strip_delim(match)

			if match:find '^%d+$' then -- is a terminal color
				local idx = tonumber(match)
				vim.validate {index = {idx, validate_terminal, '1–16'}}
				return left_delim .. (vim.g['terminal_color_' .. (idx - 1)] or ''):upper() .. right_delim
			end

			--- The last attribute whose value was checked
			--- @type string
			local attribute = 'fg'

			--- What to replace `match` with
			--- @type highlite.Fmt.string.substitution
			local substitution

			-- iterate over alternations in `${Foo.bg | Foo.fg}`
			for m in vim.gsplit(match, '|', {plain = true, trimempty = true}) do
				--- e.g. `@text.literal.fg` → `{'@text', 'literal', 'fg'}`
				local split = vim.split(vim.trim(m), '.', {plain = true, trimempty = true})

				attribute = table.remove(split) --- @type string
				vim.validate {attribute = {attribute, validate_attribute, VALIDATE_ATTRIBUTE_MSG}}

				local group = table.concat(split, '.') --- @type string

				local definition = hl_cache[group]
				if definition == nil then
					definition = vim.api.nvim_get_hl(0, {link = false, name = group})
					hl_cache[group] = definition
				end

				local formatted = fmt_attribute(definition, attribute)
				if formatted ~= nil then -- value exists, we're done
					if opts.map[attribute] then
						formatted = opts.map[attribute](formatted)
					end

					substitution = formatted
				end

				if substitution ~= nil then -- value found; we're done
					break
				end
			end

			-- Try to use the configured defaults, if they are present
			if substitution == nil and opts.default ~= true then
				substitution = opts.default[attribute]
			end

			-- If:
			--   1. There were no configured defaults, or
			--   2. There were configured defaults, but they returned `nil`,
			-- Then fall back on the predetermined defaults.
			if substitution == nil then
				local default = FMT_STRING_DEFAULT_SUBSTITUTIONS[attribute]
				if type(default) == 'string' then
					default = left_delim .. default .. right_delim
				end

				substitution = default
			end

			return tostring(substitution)
		end)
	end
end

return Fmt
