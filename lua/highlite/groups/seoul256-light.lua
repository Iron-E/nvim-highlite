local seoul_from_palette = require 'highlite.groups.seoul256' --- @type highlite.groups.from_palette

--- Generate the default highlight groups using the `palette`.
--- @type highlite.groups.from_palette
local function from_palette(palette, opts)
	return seoul_from_palette(palette, opts)
end

return from_palette
