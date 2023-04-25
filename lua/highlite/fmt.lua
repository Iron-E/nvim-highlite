--- @class highlite.Fmt
local Fmt = {}

do
	--- @class highlite.Fmt.string.opts
	--- @field convert_int_attributes? 'hex_literal'|'hex_string' if `Foo.bar` is an integer (e.g. when `Normal.fg == 16777215`), convert it to a hex string (e.g. `'#FFFFFF'`) or a hex literal (e.g. `0xFFFFFF`)
	--- @field default? true|string if `true`, use default values when formatting returns `nil` for a highlight group
	--- @field loadstring_compat? boolean if `true`, enable compatability for `loadstring`ing the returned value
	local FMT_STRING_DEFUALT_OPTS =
	{
		convert_int_attributes = 'hex_string',
		default = true,
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
	--- @param attribute string
	local function validate_attribute(attribute)
		return FMT_STRING_DEFAULT_SUBSTITUTIONS[attribute] ~= nil
	end

	--- @param cb fun(s: integer): string
	--- @return fun(definition: table, attribute: string): nil|integer|string
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
		elseif opts.default == nil then
			opts.default = FMT_STRING_DEFUALT_OPTS.default
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
			fmt_attribute = function(definition, attribute) return definition[attribute] end
		end

		return format:gsub(FMT_STRING_PATTERN, function(match)
			match = fmt_string_strip_delim(match)

			if match:find '^%d+$' then -- is a terminal color
				return left_delim .. (vim.g['terminal_color_' .. (tonumber(match) - 1)] or ''):upper() .. right_delim
			end

			--- The last attribute whose value was checked
			--- @type string
			local attribute = 'fg'

			--- What to replace `match` with
			--- @type nil|integer|string
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
					substitution = formatted
					break
				end
			end

			if substitution == nil then
				if opts.default == true then
					local default = FMT_STRING_DEFAULT_SUBSTITUTIONS[attribute]
					if type(default) == 'string' then
						default = left_delim .. default .. right_delim
					end

					substitution = tostring(default)
				else
					--- @diagnostic disable-next-line:cast-local-type we JUST checked `default == true`
					substitution = opts.default
				end
			end

			return substitution
		end)
	end
end

return Fmt
