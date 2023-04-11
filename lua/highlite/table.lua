--- @class highlite.Table
local Table = {}

--- @param t? {[any]: any}
--- @return boolean
function Table.is_empty(t)
	return t == nil or vim.tbl_isempty(t)
end

return Table
