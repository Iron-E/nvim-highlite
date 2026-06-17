local Fs = require("highlite.fs") --- @type highlite.Fs

--- @param format string
--- @return highlite.export.format
local function wrap(format)
	return function(...)
		--- @type highlite.export.format.module
		local export = require("highlite.export." .. format)
		local file, content, opts = export(...)
		Fs.write(file, content, opts)
	end
end

--- @class highlite.Export
local Export = {
	bat = wrap("bat"),
	fish = wrap("fish"),
	ghostty = wrap("ghostty"),
	leaf = wrap("leaf"),
	nvim = wrap("native.lua"),
	ripgrep = wrap("ripgrep"),
	vim = wrap("native.vim"),
	wezterm = wrap("wezterm"),
}

return Export
