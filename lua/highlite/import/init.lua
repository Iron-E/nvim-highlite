local Fs = require("highlite.fs") --- @type highlite.Fs
local Table = require("highlite.table") --- @type highlite.Table

--- @param format string
--- @return highlite.import.format
local function wrap(format)
	return function(...)
		return require("highlite.import." .. format)(...)
	end
end

--- @class highlite.Import
local Import = {
	nvim = wrap("native"),
}

do
	--- The format for a new `:colorscheme` file
	local COLORSCHEME_FMT = [[
local Highlite = require("highlite") --- @type Highlite

local palette, terminal_palette = Highlite.palette("%s")
Highlite.generate("%s", Highlite.groups("%s", palette), terminal_palette)
]]

	--- The colorschemes native to Neovim, plus the defaults managed by in this plugin.
	local DEFAULT_IGNORED = {
		blue = true,
		darkblue = true,
		default = true,
		delek = true,
		desert = true,
		elflord = true,
		evening = true,
		habamax = true,
		industry = true,
		koehler = true,
		lunaperche = true,
		morning = true,
		murphy = true,
		pablo = true,
		peachpuff = true,
		quiet = true,
		retrobox = true,
		ron = true,
		shine = true,
		slate = true,
		sorbet = true,
		torte = true,
		unokai = true,
		vim = true,
		wildcharm = true,
		zaibatsu = true,
		zellner = true,
	}

	--- @type highlite.import.format.opts
	local IMPORT_OPTS = { convert_int_attributes = "hex_literal" }

	local NEW_LINE = "\n\t\t\t"

	--- The format for a new color palette file
	local PALETTE_FMT = [[
--- @type highlite.color.palette.get
local function get(bg, get_terminal)
	local palette, terminal_palette
	if bg ~= "light" then
		if get_terminal then
			terminal_palette = {%s
			}
		end

		palette = {%s
		}
	else
		if get_terminal then
			terminal_palette = {%s
			}
		end

		palette = {%s
		}
	end

	return require("highlite.color.palette")._derive(palette), terminal_palette
end

return get
]]

	--- @type highlite.Fs.write.opts
	local WRITE_OPTIONS = { force = true, silent = true }

	--- Format a palette to insert in the `PALETTE_FMT`
	--- @package
	--- @param p highlite.color.palette
	--- @return string
	local function fmt_palette(p)
		local s = ""
		for color, value in vim.spairs(p) do
			s = s .. NEW_LINE .. color .. " = " .. value .. ","
		end

		return s
	end

	--- Format a terminal palette to insert in the `PALETTE_FMT`
	--- @package
	--- @param t highlite.color.palette.terminal
	--- @return string
	local function fmt_terminal(t)
		local s = ""
		for i, color in ipairs(t) do
			s = s .. NEW_LINE .. "\t[" .. i .. "] = " .. color .. ","
		end

		return s
	end

	--- @class highlite.Import._all_nvim_to_highlite.opts.match
	--- @field patterns? string[]
	--- @field raw? string[]

	--- @class highlite.Import._all_nvim_to_highlite.opts
	--- @field repo_dir? string the path to the nvim-highlite repository on-disk
	--- @field exclude? highlite.Import._all_nvim_to_highlite.opts.match
	--- @field include? highlite.Import._all_nvim_to_highlite.opts.match

	--- @async
	--- @param opts highlite.Import._all_nvim_to_highlite.opts
	--- @return { [string]: true }
	local function get_selected_colorschemes(opts)
		--- @type { [string]: true }
		local colorschemes = {}
		if opts.include == nil then
			for _, v in ipairs(vim.fn.getcompletion("*", "color")) do
				colorschemes[v] = true
			end
		else
			if opts.include.raw ~= nil then
				for _, v in ipairs(opts.include.raw) do
					colorschemes[v] = true
				end
			end

			if opts.include.patterns ~= nil then
				for _, pattern in ipairs(opts.include.patterns) do
					for _, v in ipairs(vim.fn.getcompletion(pattern, "color")) do
						colorschemes[v] = true
					end
				end
			end
		end

		if opts.include ~= nil then
			if opts.include.raw ~= nil then
				for _, v in ipairs(opts.include.raw) do
					colorschemes[v] = nil
				end
			end

			if opts.include.patterns ~= nil then
				for _, pattern in ipairs(opts.include.patterns) do
					for _, v in ipairs(vim.fn.getcompletion(pattern, "color")) do
						colorschemes[v] = nil
					end
				end
			end
		end

		return colorschemes
	end

	--- Import the selected (installed) neovim colorschemes to this repository, creating color palettes and colorscheme files
	--- for each. The built-in colorschemes (i.e. `nvim --clean`) are ignored.
	--- @private
	--- @async
	--- @param opts highlite.Import._all_nvim_to_highlite.opts
	function Import._to_highlite(opts)
		local repo_dir = opts.repo_dir
		if repo_dir == nil then
			repo_dir = vim.fs.dirname(
				vim.fs.dirname(
					vim.fs.dirname(
						vim.fs.dirname(vim.fs.normalize(vim.fn.fnamemodify(debug.getinfo(1, "S").source, ":~:.")))
					)
				)
			)

			if vim.startswith(repo_dir, "@") then
				repo_dir = repo_dir:sub(2)
			end
		end

		--- The place where `:colorscheme` files go
		local colors_dir = repo_dir .. "/colors/"

		--- The place where palettes go
		local groups_dir = repo_dir .. "/lua/highlite/groups/"

		--- The place where palettes go
		local palette_dir = repo_dir .. "/lua/highlite/color/palette/"

		local colorschemes = get_selected_colorschemes(opts)

		for name, _ in pairs(colorschemes) do
			if DEFAULT_IGNORED[name] then
				goto continue -- HACK: no `continue` keyword
			end

			local imported = Import.nvim(name, IMPORT_OPTS)

			local palette_name
			if name:find("^highlite") then
				local colorscheme_file = colors_dir .. name .. ".lua"
				if Fs.exists_sync(colorscheme_file) then
					palette_name = Fs.read_sync(colorscheme_file)[3]:match("%b''"):sub(2, -2)
				end
			end

			if palette_name == nil then
				palette_name = name:gsub("_", "-"):lower()
			end

			Fs.write(
				palette_dir .. palette_name .. ".lua",
				PALETTE_FMT:format(
					fmt_terminal(imported.dark.terminal),
					fmt_palette(imported.dark.palette),
					fmt_terminal(imported.light.terminal),
					fmt_palette(imported.light.palette)
				),
				WRITE_OPTIONS
			)

			local colorscheme_name = name:gsub("_", "-"):lower()
			local groups_name = colorscheme_name:gsub("highlite%-", "")
			Fs.exists(groups_dir .. groups_name .. ".lua", function(exists)
				if not exists then
					groups_name = "default"
				end

				if colorscheme_name:find("^highlite") == nil then
					colorscheme_name = "highlite-" .. colorscheme_name
				end

				Fs.write(
					colors_dir .. colorscheme_name .. ".lua",
					COLORSCHEME_FMT:format(palette_name, colorscheme_name, groups_name),
					WRITE_OPTIONS
				)
			end)

			::continue::
		end
	end
end

return Import
