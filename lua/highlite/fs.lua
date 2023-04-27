local Table = require 'highlite.table' --- @type highlite.Table

--- @param err? any
local function catch(err)
	if err ~= nil then
		error(err, 2)
	end
end

--- @class highlite.Fs
local Fs = {}

--- @async
--- @param path string
--- @param callback fun(exists: boolean, err: nil|string)
function Fs.exists(path, callback)
	vim.loop.fs_stat(path, function(stat_err)
		local exists = stat_err == nil
		local err

		if not exists and stat_err:find 'ENOENT' == nil then
			err = stat_err
		end

		callback(exists, err)
	end)
end

--- @param path string
--- @return boolean exists, nil|string err
function Fs.exists_sync(path)
	local _, stat_err = vim.loop.fs_stat(path)

	local exists = stat_err == nil
	local err

	if not exists and stat_err:find 'ENOENT' == nil then
		err = stat_err
	end

	return exists, err
end

do
	--- `rwxr-xr-x` (see https://jameshfisher.com/2017/02/24/what-is-mode_t/)
	local BASE_MKDIR_MODE = bit.bor(
		bit.lshift(1, 8),
		bit.bor(
			bit.lshift(1, 7),
			bit.bor(
				bit.lshift(1, 6),
				bit.bor(
					bit.lshift(1, 5),
					bit.bor(
						bit.lshift(1, 3),
						bit.bor(bit.lshift(1, 2), bit.lshift(1, 0))
					)
				)
			)
		)
	)

	--- @async
	--- @param path string if `path` is `"foo/bar"`, this function will ensure `"foo"` is created.
	--- @param success_callback async fun() what to do after the parent directory's existence is successfully ensured.
	function Fs.mk_parent_dir_if_missing(path, success_callback)
		local parent = vim.fs.dirname(path)

		Fs.exists(parent, function(exists, err)
			if err then
				error('Could not stat ' .. vim.inspect(parent) .. ': ' .. err)
			elseif exists then
				success_callback() -- file exists, open and write to it
			else
				-- parent directory was missing, so try to create it
				vim.loop.fs_mkdir(parent, BASE_MKDIR_MODE, function(mkdir_err)
					catch(mkdir_err)
					success_callback()
				end)
			end
		end)
	end
end

do
	--- `r--r--r--` (see https://jameshfisher.com/2017/02/24/what-is-mode_t/)
	local BASE_OPEN_READ_MODE = bit.bor(
		bit.lshift(1, 8),
		bit.bor(bit.lshift(1, 5), bit.lshift(1, 2))
	)

	--- @param path string
	--- @return string[] content
	function Fs.read_sync(path)
		local stat, stat_err = vim.loop.fs_stat(path)
		catch(stat_err)

		local file, open_err = vim.loop.fs_open(path, 'r', BASE_OPEN_READ_MODE)
		catch(open_err)

		local content, read_err = vim.loop.fs_read(file, stat.size)
		catch(read_err)

		local closed, close_err = vim.loop.fs_close(file)
		catch(close_err)

		if closed == false then
			error('Failed to close ' .. path)
		end

		return vim.split(content, '\n')
	end
end

do
	--- `rw-r--r--` (see https://jameshfisher.com/2017/02/24/what-is-mode_t/)
	local BASE_OPEN_WRITE_MODE = bit.bor(
		bit.lshift(1, 8),
		bit.bor(
			bit.lshift(1, 7),
			bit.bor(bit.lshift(1, 5), bit.lshift(1, 2))
		)
	)

	--- @class highlite.Fs.write.opts
	--- @field force? boolean if `true`, forcefully write to the file even if it exists.
	--- @field silent? boolean if `true`, do not notify when write completes
	local DEFAULT_WRITE_OPTS = {force = false, silent = false}

	--- @async
	--- @param path string
	--- @param content string
	--- @param silent? boolean
	local function open_and_write(path, content, silent)
		vim.loop.fs_open(path, 'w', BASE_OPEN_WRITE_MODE, function(open_err, file)
			catch(open_err)
			vim.loop.fs_write(file, content, function(write_err)
				catch(write_err)
				vim.loop.fs_close(file, function(close_err)
					catch(close_err)
					if not silent then
						vim.schedule(function()
							vim.notify('Successfully wrote to ' .. path, vim.log.levels.INFO, {title = 'nvim-highlite'})
						end)
					end
				end)
			end)
		end)
	end

	--- @async
	--- @param path string
	--- @param content string
	--- @param opts? highlite.Fs.write.opts
	function Fs.write(path, content, opts)
		if Table.is_empty(opts) then opts = DEFAULT_WRITE_OPTS end
		--- @cast opts -nil

		--- @async
		local function write() open_and_write(path, content, opts.silent) end

		-- make sure we aren't overwriting an existing file
		if opts.force == false then
			return Fs.exists(path, function(exists)
				if exists then
					--- NOTE: `vim.schedule` because `vim.fn.` can't be called from loop callbacks
					vim.schedule(function()
						-- File exists — generate a new file with a timestamp inserted.
						path = vim.fn.fnamemodify(path, ':r') .. '-' ..
							os.date('%Y_%m_%d-%H_%M_%S') .. '.' ..
							vim.fn.fnamemodify(path, ':e')

						write()
					end)
				else
					-- file missing, make sure the parent exists
					Fs.mk_parent_dir_if_missing(path, write)
				end
			end)
		end

		-- make sure parent directory exists
		Fs.mk_parent_dir_if_missing(path, write)
	end
end

return Fs
