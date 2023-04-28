--- Switch the current colorscheme, clearing all remnants of the previous colorscheme
--- @param name string
local function switch_colorscheme(name)
	vim.api.nvim_command 'highlight clear'
	for i = 0, 15 do
		vim.g['terminal_color_' .. i] = nil
	end

	vim.api.nvim_command('colorscheme ' .. name)
end

--- @class highlite.Nvim
local Nvim = {}

--- Call the `fn` while the alternate `&bg` value is applied, then restore the original `&bg` value.
--- @param fn fun(bg: highlite.bg)
--- @return highlite.bg original_bg
function Nvim.with_alt_bg(fn)
	local previous_bg = vim.api.nvim_get_option 'background' --- @type highlite.bg
	local next_bg = previous_bg == 'dark' and 'light' or 'dark' --- @type highlite.bg

	vim.api.nvim_set_option('background', next_bg)
	fn(next_bg)
	vim.api.nvim_set_option('background', previous_bg)

	return previous_bg
end

--- Call the `fn` while the colorscheme `name` is applied, then restore the originally used colorscheme.
--- @param name string the temporary colorscheme
--- @param fn fun()
function Nvim.with_colorscheme(name, fn)
	local previous_colorscheme = vim.api.nvim_get_var 'colors_name'
	switch_colorscheme(name)
	fn()
	switch_colorscheme(previous_colorscheme)
end

return Nvim
