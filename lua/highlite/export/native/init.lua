--- @class highlite.export.Native
local Native = {}

--- Skip plugins that don't depend on a colorscheme
--- @param group string
--- @return boolean filter_it
function Native.default_hl_group_filter(group)
	return (group:find '^colorizer_' or group:find '^DevIcon' or group:find '^Stl_?[1-9a-f]*') ~= nil
end

return Native
