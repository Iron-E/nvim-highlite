local default_groups_from_palette = require 'highlite.groups.default' --- @type highlite.groups.from_palette
local Groups = require 'highlite.groups' --- @type highlite.Groups

--- Generate the default highlight groups using the `palette`.
--- @type highlite.groups.from_palette
local function from_palette(palette, opts)
	local groups = default_groups_from_palette(palette, opts)

	groups.Error = Groups.extend({fg = palette.text}, groups'Error')

	return groups
end

return from_palette
