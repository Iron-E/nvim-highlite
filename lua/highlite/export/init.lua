local Fs = require 'highlite.fs' --- @type highlite.Fs

--- @param format string
--- @return highlite.export.format
local function wrap(format)
	return function(...) Fs.write(require('highlite.export.' .. format)(...)) end
end

--- @class highlite.Export
local Export =
{
	nvim = wrap 'native.lua',
	vim = wrap 'native.vim',
	wezterm = wrap 'wezterm',
}

return Export
