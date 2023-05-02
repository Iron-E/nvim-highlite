local Treesitter = require 'highlite.treesitter' --- @type highlite.Treesitter

if vim.api.nvim_get_var('colors_name'):find '^highlite' then
	Treesitter.add_directive.offset_from_start()
end
