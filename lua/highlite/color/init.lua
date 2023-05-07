local band = bit.band
local floor = math.floor
local lshift = bit.lshift
local max = math.max
local min = math.min
local rshift = bit.rshift

--- @alias highlite.color.hex integer
--- @alias highlite.color highlite.color.hex|string

--- The maximum that any one part of an `"#RRGGBB"` color string can be
local MAX = 0xFF

--- @param color highlite.color.hex the complete color
--- @param channel_bit integer the channel starting bit
--- @param factor integer amount to multiply the color channel by
--- @return highlite.color.hex accented_channel
local function multiply_channel(color, channel_bit, factor)
	--- Shift the value all the way to the right, and mask it.
	local masked_value = band(MAX, rshift(color, channel_bit))

	-- multiply the value by the factor, ensure it is between 0-FF, and shift it back to where it was before.
	return lshift(min(MAX, max(0, floor(masked_value * factor))), channel_bit)
end

--- @class highlite.colors
--- @field [string] nil|highlite.color

--- @class highlite.Color
local Color = {}

--- Example:
---
--- ```lua
--- accent(0x505050, 2) -- a0a0a0
--- ```
--- @param color highlite.color the color to accent
--- @param factor integer amount to multiply the red channel by
--- @return highlite.color.hex accented
function Color.saturate(color, factor)
	if type(color) == 'string' then
		local normalized = color:gsub('#', '0x')
		color = tonumber(normalized) or error('Could not interpret color ' .. vim.inspect(color))
	end

	return multiply_channel(color, 16, factor) +
		multiply_channel(color, 8, factor) +
		multiply_channel(color, 0, factor)
end

return Color
