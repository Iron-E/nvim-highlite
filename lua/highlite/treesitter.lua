--- @class highlite.Treesitter
local Treesitter = {add_directive = {}}

--- Add the `#offset-from-start!` directive, which is similar to `#offset!` except that it offsets based on the
--- location beginning of the capture.
function Treesitter.add_directive.offset_from_end()
	vim.treesitter.query.add_directive('offset-from-end!',
		--- @param match {active: boolean, pattern: integer, [integer]: nil|TSNode}
		--- @param predicate {[1]: string, [2]: integer, [3]: nil|integer, [4]: nil|integer, [5]: nil|integer, [6]: nil|integer}
		--- @param metadata table
		function(match, _, _, predicate, metadata)
			local capture_id = predicate[2]
			if not metadata[capture_id] then
				metadata[capture_id] = {}
			end

			local range = metadata[capture_id].range or {match[capture_id]:range()}
			local start_row_offset = predicate[3] or 0
			local start_col_offset = predicate[4] or 0
			local end_row_offset = predicate[5] or 0
			local end_col_offset = predicate[6] or 0

			range[1] = range[3] + start_row_offset
			range[2] = range[4] + start_col_offset
			range[3] = range[3] + end_row_offset
			range[4] = range[4] + end_col_offset

			-- If this produces an invalid range, we just skip it.
			if range[1] < range[3] or (range[1] == range[3] and range[2] <= range[4]) then
				metadata[capture_id].range = range
			end
		end,
		true
	)
end

function Treesitter.add_directive.offset_from_start()
	vim.treesitter.query.add_directive('offset-from-start!',
		--- @param match {active: boolean, pattern: integer, [integer]: nil|TSNode}
		--- @param predicate {[1]: string, [2]: integer, [3]: nil|integer, [4]: nil|integer, [5]: nil|integer, [6]: nil|integer}
		--- @param metadata table
		function(match, _, _, predicate, metadata)
			local capture_id = predicate[2]
			if not metadata[capture_id] then
				metadata[capture_id] = {}
			end

			local range = metadata[capture_id].range or {match[capture_id]:range()}
			local start_row_offset = predicate[3] or 0
			local start_col_offset = predicate[4] or 0
			local end_row_offset = predicate[5] or 0
			local end_col_offset = predicate[6] or 0

			range[1] = range[1] + start_row_offset
			range[2] = range[2] + start_col_offset
			range[3] = range[1] + end_row_offset
			range[4] = range[2] + end_col_offset

			-- If this produces an invalid range, we just skip it.
			if range[1] < range[3] or (range[1] == range[3] and range[2] <= range[4]) then
				metadata[capture_id].range = range
			end
		end,
		true
	)
end

return Treesitter
