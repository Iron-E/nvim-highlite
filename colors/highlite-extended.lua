local palette, terminal_palette = require('highlite.color.palette.default')(vim.api.nvim_get_option 'background', true)

require('highlite').setup(
	'highlite-extended',
	require('highlite.groups.default-extended')(palette),
	terminal_palette
)
