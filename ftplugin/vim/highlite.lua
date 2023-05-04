if vim.api.nvim_get_var('colors_name'):find '^highlite' then
	require('highlite.treesitter').add_directive.offset_from_end()
end
