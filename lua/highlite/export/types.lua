--- @meta

--- @alias highlite.export.options.filter fun(group, default_filter: fun(group): boolean): boolean

--- @class highlite.export.options: highlite.Fs.write.opts
--- @field dir? string the output directory
--- @field filter? highlite.export.options.filter if this function returns `true`, then the `group` will be skipped
--- @field filename? string the name of the file without an extension

--- @alias highlite.export.format async fun(colorscheme: string, opts?: highlite.export.options, dir_DEPRECATED?: string)

--- @alias highlite.export.format.module fun(colorscheme: string, opts?: highlite.export.options, dir_DEPRECATED?: string): string, string, highlite.export.options
