--- @class highlite.export.Util
local Util = {}

--- attempts to resolve the directory for exporting, whether by using a secondary `dir` or a `fallback`.
--- if the fallback fails, then it will use the current working directory
--- @param name string the name of the export whose directory is being resolved
--- @param dir string the directory which the user passed in
--- @param fallback fun(): string a way to automatically detect the correct directory to use. Will be `pcall`ed.
--- @return string export_dir
function Util.get_dir(name, dir, fallback)
	if dir then
		return dir
	end

	local ok, result = pcall(fallback)
	if not ok then
		vim.notify(
			vim.inspect({
				msg = 'Could not automatically determine ' .. name .. ' configuration directory, please pass `dir` option',
				err = result,
			}),
			vim.log.levels.WARN
		)

		return vim.loop.cwd()
	end

	return result
end

--- Runs `Util.get_dir` and then `vim.fs.normalize` on the output
--- @param name string the name of the export whose directory is being resolved
--- @param dir string the directory which the user passed in
--- @param fallback fun(): string a way to automatically detect the correct directory to use. Will be `pcall`ed.
--- @return string normalized_export_dir
--- @see highlite.export.Util.get_dir
function Util.get_normalized_dir(name, dir, fallback)
	dir = Util.get_dir(name, dir, fallback)
	return vim.fs.normalize(dir)
end
