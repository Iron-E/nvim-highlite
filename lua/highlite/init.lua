local Table = require 'highlite.table' --- @type highlite.Table

--- @class highlite.config
--- @field generate highlite.groups.from_palette.opts options for highlight group generation
--- @field terminal_palette boolean if `false`, skip setting the terminal colors.
local DEFAULT_CONFIG =
{
	generate = {plugins = true, syntax = true},
	terminal_palette = true,
}

--- @type highlite.config
local config = DEFAULT_CONFIG

--- A Neovim plugin to create more straightforward syntax for Lua `:map`ping and `:unmap`ping.
--- @class Highlite
local Highlite = {}

--- @param scheme_name string the name of the colorscheme
--- @param groups highlite.groups the highlight groups used in the colorscheme
--- @param terminal_palette? highlite.color.palette.terminal the color palette of the terminal
function Highlite.generate(scheme_name, groups, terminal_palette)
	if Table.is_empty(terminal_palette) then
		terminal_palette = {}
	end

	--- @cast terminal_palette -nil

	vim.api.nvim_command 'highlight clear'
	for name, definition in pairs(groups) do
		if type(definition) == 'string' then -- `definition` is a link
			definition = {link = definition}
		end

		vim.api.nvim_set_hl(0, name, definition)
	end

	vim.api.nvim_set_var('terminal_color_0', terminal_palette[1])
	vim.api.nvim_set_var('terminal_color_1', terminal_palette[2])
	vim.api.nvim_set_var('terminal_color_2', terminal_palette[3])
	vim.api.nvim_set_var('terminal_color_3', terminal_palette[4])
	vim.api.nvim_set_var('terminal_color_4', terminal_palette[5])
	vim.api.nvim_set_var('terminal_color_5', terminal_palette[6])
	vim.api.nvim_set_var('terminal_color_6', terminal_palette[7])
	vim.api.nvim_set_var('terminal_color_7', terminal_palette[8])
	vim.api.nvim_set_var('terminal_color_8', terminal_palette[9])
	vim.api.nvim_set_var('terminal_color_9', terminal_palette[10])
	vim.api.nvim_set_var('terminal_color_10', terminal_palette[11])
	vim.api.nvim_set_var('terminal_color_11', terminal_palette[12])
	vim.api.nvim_set_var('terminal_color_12', terminal_palette[13])
	vim.api.nvim_set_var('terminal_color_13', terminal_palette[14])
	vim.api.nvim_set_var('terminal_color_14', terminal_palette[15])
	vim.api.nvim_set_var('terminal_color_15', terminal_palette[16])

	vim.api.nvim_set_var('colors_name', scheme_name)
end

--- @param palette highlite.color.palette
--- @param name highlite.groups.shortname
--- @return highlite.groups.FromPalette
function Highlite.groups(name, palette)
	return require('highlite.groups.' .. name)(palette, config.generate)
end

--- @param name highlite.color.palette.shortname
--- @return highlite.color.palette, nil|highlite.color.palette.terminal
function Highlite.palette(name)
	return require('highlite.color.palette.' .. name)(
		vim.api.nvim_get_option 'background',
		config.terminal_palette
	)
end

--- Set the global options for generating groups.
--- @param opts? table
function Highlite.setup(opts)
	if Table.is_empty(opts) then
		opts = DEFAULT_CONFIG
	else
		--- @cast opts -nil

		if Table.is_empty(opts.generate) then
			opts.generate = DEFAULT_CONFIG.generate
		else
			local generate = opts.generate

			if generate.plugins == nil then
				generate.plugins = DEFAULT_CONFIG.generate.plugins
			elseif type(generate.plugins) == 'table' then
				if generate.plugins.nvim == nil then
					generate.plugins.nvim = DEFAULT_CONFIG.generate.plugins.nvim
				end

				if generate.plugins.vim == nil then
					generate.plugins.vim = DEFAULT_CONFIG.generate.plugins.vim
				end
			end

			if generate.syntax == nil then
				generate.syntax = DEFAULT_CONFIG.generate.syntax
			end
		end

		if opts.terminal_palette == nil then
			opts.terminal_palette = DEFAULT_CONFIG.terminal_palette
		end
	end

	config = opts
end

return Highlite
