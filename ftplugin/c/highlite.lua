if vim.api.nvim_get_var('colors_name'):find '^highlite' then
	local Treesitter = require 'highlite.treesitter' --- @type highlite.Treesitter
	Treesitter.add_directive.offset_from_end()
	Treesitter.add_directive.offset_from_start()
end
