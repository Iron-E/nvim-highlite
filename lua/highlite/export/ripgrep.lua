local Fmt = require("highlite.fmt") --- @type highlite.Fmt
local Nvim = require("highlite.nvim") --- @type highlite.Nvim

local FMT = [[
--colors=path:none
--colors=path:fg:${@string.special.path.sp | @string.special.path.fg | Directory.sp | Directory.fg}
--colors=path:bg:${@string.special.path.bg | Directory.bg}
--colors=path:style:${@string.special.path.bold | @string.special.path.undercurl | @string.special.path.underdashed | @string.special.path.underdotted | @string.special.path.underdouble | @string.special.path.underline | Directory.bold | Directory.undercurl | Directory.underdashed | Directory.underdotted | Directory.underdouble | Directory.underline}

--colors=line:none
--colors=line:fg:${CursorLineNr.sp | CursorLineNr.fg}
--colors=line:bg:${CursorLineNr.bg}
--colors=line:style:${CursorLineNr.bold | CursorLineNr.undercurl | CursorLineNr.underdashed | CursorLineNr.underdotted | CursorLineNr.underdouble | CursorLineNr.underline}

--colors=column:none
--colors=column:fg:${LineNr.sp | LineNr.fg}
--colors=column:bg:${LineNr.bg}
--colors=column:style:${LineNr.bold | LineNr.undercurl | LineNr.underdashed | LineNr.underdotted | LineNr.underdouble | LineNr.underline}

--colors=match:none
--colors=match:fg:${Search.sp | Search.fg}
--colors=match:bg:${Search.bg}
--colors=match:style:${Search.bold | Search.undercurl | Search.underdashed | Search.underdotted | Search.underdouble | Search.underline}
]]

--- @type highlite.Fmt.string.opts
local FMT_OPTS = {
	default = {
		bold = '"none"',
	},

	map = {
		bold = function()
			return "bold"
		end,
		underline = function()
			return "underline"
		end,

		--- @param value string
		--- @return string
		bg = function(value)
			local without_quotes = value:sub(2, -2)
			local red = without_quotes:sub(2, -5)
			local green = without_quotes:sub(4, -3)
			local blue = without_quotes:sub(6)

			return "0x" .. red .. "," .. "0x" .. green .. "," .. "0x" .. blue
		end,
	},
}

FMT_OPTS.default.undercurl = FMT_OPTS.default.bold
FMT_OPTS.default.underdashed = FMT_OPTS.default.bold
FMT_OPTS.default.underdotted = FMT_OPTS.default.bold
FMT_OPTS.default.underdouble = FMT_OPTS.default.bold
FMT_OPTS.default.underline = FMT_OPTS.default.bold

FMT_OPTS.map.fg = FMT_OPTS.map.bg
FMT_OPTS.map.sp = FMT_OPTS.map.bg

FMT_OPTS.map.undercurl = FMT_OPTS.map.underline
FMT_OPTS.map.underdashed = FMT_OPTS.map.underline
FMT_OPTS.map.underdotted = FMT_OPTS.map.underline
FMT_OPTS.map.underdouble = FMT_OPTS.map.underline

--- @param opts highlite.export.options
--- @return string ripgrep_config_path
local function ripgrep_config_path(colorscheme, opts)
	-- If the dir was specified, us it
	if opts.dir ~= nil then
		-- use the filename if specified, else the colorscheme name
		return opts.dir .. "/" .. (opts.filename or colorscheme)
	end

	-- otherwise, try to use the official env var
	local path = vim.loop.os_getenv("RIPGREP_CONFIG_PATH")
	if path ~= nil then
		return path
	end

	-- else, default to CWD and the same filename/colorscheme fallback as above
	return vim.loop.cwd() .. "/" .. (opts.filename or colorscheme)
end

--- Create a wezterm theme out of the `palette`
--- @type highlite.export.format.module
local function export(colorscheme, opts, dir)
	if opts == nil then
		opts = { dir = dir }
	elseif opts.dir == nil then
		opts.dir = dir
	end

	local path = vim.fs.normalize(ripgrep_config_path(colorscheme, opts))

	local formatted --- @type string
	Nvim.with_colorscheme(colorscheme, function()
		formatted = Fmt.string(FMT, FMT_OPTS)
	end)

	local content = formatted:gsub('--colors=%w+:%w+:"none"\n', "")
	return path, content, opts
end

return export
