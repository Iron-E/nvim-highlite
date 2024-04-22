local Table = require 'highlite.table' --- @type highlite.Table

-- TODO: use `TreesitterAttach` when it is available {{{
vim.api.nvim_create_autocmd('SourcePost', { once = true, callback = function()
	local opts = { force = false, all = true }

	do
		--- @param match {active: boolean, pattern: integer, [integer]: nil|TSNode}
		--- @param predicate {[1]: string, [2]: 'end'|'start', [3]: integer, [4]: nil|integer, [5]: nil|integer, [6]: nil|integer, [7]: nil|integer}
		--- @param metadata table
		local function handler(match, _, _, predicate, metadata)
			local from = predicate[2]
			local capture_id = predicate[3]
			local start_row_offset = predicate[4] or 0
			local start_col_offset = predicate[5] or 0
			local end_row_offset = predicate[6] or 0
			local end_col_offset = predicate[7] or 0

			local nodes = match[capture_id]
			if nodes == nil then
				return
			end

			--- NOTE: `nodes` is a table on nvim 0.10+
			local node = type(nodes) == 'table' and nodes[1] or nodes

			if not metadata[capture_id] then
				metadata[capture_id] = {}
			end

			local range = metadata[capture_id].range or { node:range() }

			if from == 'end' then
				range[1] = range[3] + start_row_offset
				range[2] = range[4] + start_col_offset
				range[3] = range[3] + end_row_offset
				range[4] = range[4] + end_col_offset
			else
				-- NOTE: have to assign `3` & `4` because assigning `1` & `2` alters the relative offset
				range[3] = range[1] + end_row_offset
				range[4] = range[2] + end_col_offset
				range[1] = range[1] + start_row_offset
				range[2] = range[2] + start_col_offset
			end

			-- If this produces an invalid range, we just skip it.
			if range[1] < range[3] or (range[1] == range[3] and range[2] <= range[4]) then
				metadata[capture_id].range = range
			end
		end

		vim.treesitter.query.add_directive('offset-from!', handler, opts)
	end

	-- HACK: must backport `any-` TS query predicates to 0.9, however there is no way to
	--       `vim.treesitter.query.get_predicate_handler`. So these are all copied from source.
	--
	-- TODO: remove when bumping minimum version to 0.10
	if vim.fn.has('nvim-0.10') < 1 then
		vim.treesitter.query.add_predicate('any-contains?', function(match, _, source, predicate)
			local nodes = match[predicate[2]]
			if not nodes or #nodes == 0 then
				return true
			end

			for _, node in ipairs(nodes) do
				local node_text = vim.treesitter.get_node_text(node, source)

				for i = 3, #predicate do
					local res = string.find(node_text, predicate[i], 1, true)
					if not res then
						return false
					end
				end
			end

			return true
		end)

		vim.treesitter.query.add_predicate('any-eq?', function(match, _, source, predicate)
			local nodes = match[predicate[2]]
			if not nodes or #nodes == 0 then
				return true
			end

			for _, node in ipairs(nodes) do
				local node_text = vim.treesitter.get_node_text(node, source)

				local str ---@type string
				if type(predicate[3]) == 'string' then
					-- (#eq? @aa "foo")
					str = predicate[3]
				else
					-- (#eq? @aa @bb)
					local other = assert(match[predicate[3]])
					assert(#other == 1, '#eq? does not support comparison with captures on multiple nodes')
					str = vim.treesitter.get_node_text(other[1], source)
				end

				local res = str ~= nil and node_text == str
				if not res then
					return false
				end
			end

			return true
		end)

		--- @param match table<integer,TSNode[]>
		--- @param source integer|string
		--- @param predicate any[]
		vim.treesitter.query.add_predicate('any-lua-match?', function(match, _, source, predicate)
			local nodes = match[predicate[2]]
			if not nodes or #nodes == 0 then
				return true
			end

			for _, node in ipairs(nodes) do
				local regex = predicate[3]
				local res = string.find(vim.treesitter.get_node_text(node, source), regex) ~= nil
				if not res then
					return false
				end
			end

			return true
		end)

		do
			local magic_prefixes = { ['\\v'] = true, ['\\m'] = true, ['\\M'] = true, ['\\V'] = true }
			local function check_magic(str)
				if string.len(str) < 2 or magic_prefixes[string.sub(str, 1, 2)] then
					return str
				end
				return '\\v' .. str
			end

			local compiled_vim_regexes = setmetatable({}, {
				__index = function(t, pattern)
					local res = vim.regex(check_magic(pattern))
					rawset(t, pattern, res)
					return res
				end,
			})

			local function handler(match, _, source, predicate)
				local nodes = match[predicate[2]]
				if not nodes or #nodes == 0 then
					return true
				end

				for _, node in ipairs(nodes) do
					local regex = compiled_vim_regexes[predicate[3]] ---@type vim.regex
					local res = regex:match_str(vim.treesitter.get_node_text(node, source))
					if not res then
						return false
					end
				end
				return true
			end

			vim.treesitter.query.add_predicate('any-match?', handler)
			vim.treesitter.query.add_predicate('any-vim-match?', handler)
		end
	end
end })

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

	if vim.g.colors_name ~= nil then
		vim.api.nvim_command 'highlight clear'
	end

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
		vim.api.nvim_get_option_value('background', {}),
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
