--- @class highlite.Utils
local Utils = {}

--- Switch the current colorscheme, clearing all remnants of the previous colorscheme
--- @param name string
function Utils.switch_colorscheme(name)
	vim.cmd.highlight 'clear'
	for i = 0, 15 do
		vim.g['terminal_color_' .. i] = nil
	end

	vim.cmd.colorscheme(name)
end

return Utils
