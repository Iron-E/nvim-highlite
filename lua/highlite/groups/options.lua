--- @class highlite.groups.Options
local Options = {}

--- @param opts highlite.groups.from_palette.opts
--- @return boolean all_nvim_plugins, boolean any_nvim_plugins, boolean all_syntax, boolean any_syntax, boolean all_vim_plugins, boolean any_vim_plugins
function Options.parse_from_palette(opts)
	local all_nvim_plugins = true
	local all_syntax = true
	local all_vim_plugins = true
	local any_nvim_plugins = true
	local any_syntax = true
	local any_vim_plugins = true

	--- @cast opts -nil
	if opts.plugins == false then
		all_nvim_plugins = false
		all_vim_plugins = false
		any_nvim_plugins = false
		any_vim_plugins = false
	elseif type(opts.plugins) == 'table' then
		if opts.plugins.nvim ~= true then
			all_nvim_plugins = false

			if opts.plugins.nvim == false then
				any_nvim_plugins = false
			end
		end

		if opts.plugins.vim ~= true then
			all_vim_plugins = false

			if opts.plugins.vim == false then
				any_vim_plugins = false
			end
		end
	end

	if opts.syntax ~= true then
		all_syntax = false

		if opts.syntax == false then
			any_syntax = false
		end
	end

	return all_nvim_plugins, any_nvim_plugins, all_syntax, any_syntax, all_vim_plugins, any_vim_plugins
end

return Options
