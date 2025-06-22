local Fmt = require 'highlite.fmt' --- @type highlite.Fmt
local Nvim = require 'highlite.nvim' --- @type highlite.Nvim
local Util = require 'highlite.export.util' --- @type highlite.export.Util

local FMT = [[
background = ${Normal.bg}
foreground = ${Normal.fg | Normal.sp}
cursor-color = ${Cursor.fg | Cursor.sp | Normal.fg | Normal.sp}
cursor-text = ${Cursor.bg | Normal.bg}
selection-background = ${Visual.bg}
selection-foreground = ${Visual.fg | Visual.sp | Normal.fg | Normal.sp}
]]

--- @type highlite.Fmt.string.opts
local FMT_OPTS =
{
	default =
	{
		fg = 'null',
		bg = 'null',
		sp = 'null',
	},

	map =
	{
		--- @param value string
		--- @return string
		bg = function(value)
			return value:sub(2, -2)
		end,
	},
}

FMT_OPTS.map.fg = FMT_OPTS.map.bg
FMT_OPTS.map.sp = FMT_OPTS.map.bg

--- Create a wezterm theme out of the `palette`
--- @type highlite.export.format.module
local function export(colorscheme, opts, dir)
	if opts == nil then opts = {} end

	-- checked for backwards compatability
	dir = Util.get_normalized_dir('ghostty', dir or opts.dir, function()
		local xdg = vim.loop.os_getenv('XDG_CONFIG_HOME')
		return xdg .. '/ghostty/themes'
	end)

	local filename = opts.filename or colorscheme

	local builder = {} --- @type string[]
	Nvim.with_colorscheme(colorscheme, function()
		for i = 0, 15 do
			local color = vim.g['terminal_color_' .. i]
			if color == nil then
				goto continue
			end

			table.insert(builder, 'palette = ' .. i .. '=' .. color)

			::continue::
		end

		local formatted = Fmt.string(FMT, FMT_OPTS)
		table.insert(builder, formatted)
	end)

	local content = table.concat(builder, '\n')
	return dir .. '/' .. filename, content, opts
end

return export
