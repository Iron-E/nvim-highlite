--- @alias highlite.group.blend 0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63|64|65|66|67|68|69|70|71|72|73|74|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|92|93|94|95|96|97|98|99|100

--- @alias highlite.group.link string a |:highlight-link| to an existing highlight group

--- @class highlite.group.new a new highlight group
--- @field bg? highlite.color
--- @field blend? highlite.group.blend the transparency value
--- @field bold? boolean
--- @field default? boolean
--- @field fg? highlite.color
--- @field italic? boolean
--- @field link? string
--- @field nocombine? boolean
--- @field reverse? boolean
--- @field sp? highlite.color
--- @field standout? boolean
--- @field strikethrough? boolean
--- @field undercurl? boolean
--- @field underdashed? boolean
--- @field underdotted? boolean
--- @field underdouble? boolean
--- @field underline? boolean

--- @alias highlite.group.definition highlite.group.link|highlite.group.new a link to an existing group or a new group

--- @class highlite.groups
--- @field [string] nil|highlite.group.definition

--- @class highlite.Groups
local Groups = {}

--- Return a new highlight group definition with the same attributes of some `group`.
--- PERF: faster than `vim.deepcopy` for the case of copying highlight groups.
--- @param group highlite.group.new
--- @return highlite.group.new clone
function Groups.clone(group)
	local clone = {}
	for k, v in pairs(group) do
		clone[k] = v
	end

	return clone
end

--- Assign all attributes of `parent` to `child` which are not already defined.
--- PERF: faster than `clone`ing and setting attributes
--- WARN: this mutates `child`!
--- @param parent highlite.group.new
--- @param child highlite.group.new
--- @return highlite.group.new inherited
function Groups.extend(child, parent)
	for k, v in pairs(parent) do
		if child[k] == nil then
			child[k] = v
		end
	end

	return child
end

--- Like `inherit` but allows forcing and skipping attributes. Example:
--
--- ```lua
--- local white_bold = {fg = {'#FFFFFF', 1, 'white'}, bold = true}
--- local green_red_italic = {fg = {'#00FF00', 196, 'green'}, bg = {'#FF0000', 196, 'red'}, bold = false, italic = true}
--- local white_red_italic = inherit_selected(green_red_italic, white_bold_text, {fg = true})
--- local green_red_bold_italic = inherit_selected(green_red_italic, white_bold_text, {bold = true, fg = false})
--- ```
--
--- WARN: mutates `child`!
--- @see highlite.group.new
--- @see highlite.Groups.inherit
--- @param child highlite.group.new
--- @param parent highlite.group.new
--- @param opts {[string]: nil|boolean} if an attribute is `true`, that attribute will always be inherited. E.g. `{fg = true}` to force `fg` to be inherited.
--- @return highlite.group.new inherited
function Groups.extend_selected(child, parent, opts)
	for k, v in pairs(parent) do
		if (child[k] == nil and opts[k] ~= false) or opts[k] == true then
			child[k] = v
		end
	end

	return child
end

return Groups
