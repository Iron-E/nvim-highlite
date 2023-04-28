# Contributing

This document contains information about `nvim-highlite` which is relevant for contributors.

> **Warning**
>
> This document assumes that you have read the [usage guide](./advanced-usage.md).

## Code Style

This repository has an [editorconfig](./.editorconfig). Neovim 0.9 supports editorconfigs out of the box, but if you are using an earlier version, you may have to install a plugin.

## Project Layout

| Module                         | Description                                             |
|:-------------------------------|:--------------------------------------------------------|
| `highlite`                     | Construct & configure colorschemes                      |
| `highlite.color`               | Color manipulation functions                            |
| `highlite.color.palette`       | Palette deriving                                        |
| `highlite.color.palette.types` | Shared type definitions for built-in palettes           |
| `highlite.color.palette.<foo>` | Built-in color palettes                                 |
| `highlite.export`              | Exporting colorschemes to other formats                 |
| `highlite.fmt`                 | String formatting                                       |
| `highlite.fs`                  | Operations on the filesystem                            |
| `highlite.groups`              | Utilities for working with highlight groups             |
| `highlite.groups.options`      | User configuration resolvers                            |
| `highlite.groups.types`        | Shared type definitions for highlight group templates   |
| `highlite.groups.<foo>`        | Highlight group generation templates                    |
| `highlite.import`              | Import other colorschemes to the `nvim-highlite` format |
| `highlite.nvim`                | Nvim API utilities                                      |
| `highlite.table`               | Utilities for working with `table`s                     |

## Features

This section is about contributing new features to `nvim-highlite`.

### Export Targets

Export targets go in the [`export`](../lua/highlite/export.lua) module.

* The [`Fs`](../lua/highlite/fs.lua) module will be of use for writing the end result.

There has an internal string formatting library that allows you to easily write a template for whatever you need, and all the logic will be handled behind the scenes:

```lua
function Fmt.string(format: string, opts?: highlite.Fmt.string.opts)
  -> formatted: string, count: integer
```

The `opts` are as follows:

```lua
--- @class highlite.Fmt.string.opts
--- @field convert_int_attributes? false|'hex_literal'|'hex_string' if `Foo.bar` is an integer (e.g. when `Normal.fg == 16777215`), convert it to a hex string (e.g. `'#FFFFFF'`) or a hex literal (e.g. `0xFFFFFF`)
--- @field default? true|{[string]: highlite.Fmt.string.substitution} if `true`, use default values when formatting returns `nil` for a highlight group
--- @field loadstring_compat? boolean if `true`, enable compatability for `loadstring`ing the returned value
--- @field map? fun(attribute: string, value: highlite.Fmt.string.substitution): highlite.Fmt.string.substitution
local FMT_STRING_DEFUALT_OPTS = {
  convert_int_attributes = 'hex_string',
  default = true,
}
```

For example, you can do this:

```lua
local Fmt = require 'highlite.fmt' --- @type highlite.Fmt
local formatted = Fmt.string [[
normal_bg = ${Normal.bg}
fallback_bg = ${undefined_group.bg | defined_group.underline}
terminal_idx_1 = ${1}
]]
```

* The [`import`](../lua/highlite/import.lua) and [`export`](../lua/highlite/export.lua) modules have more examples.

### Import Targets

Import targets go in the [`import`](../lua/highlite/import.lua) module.

* The [`Fs`](../lua/highlite/fs.lua) module will be of use for file reading.

Depending on the format, you might have to write a custom parser. Neovim supports JSON with `vim.json`, Lua can be read with `loadstring`, and VimScript can be parsed with `nvim_parse_expression`.

Considering the open-ended nature of this topic, open an issue if you have trouble working on what you would like to do.

### Palettes

> **Note**
>
> If you are looking to correct how a built-in colorscheme looks with regards to its original, it *might* be necessary to create palette-specific [highlight groups](#highlight-groups):
>
> * If an entire category of highlights is wrong, adjusting the palette is correct.
> * If only one group is wrong, adjusting the groups is correct.

If you would like to add a new palette to `nvim-highlite`:

1. First create a file with the same name as your palette in the [palette](./lua/highlite/color/palette) directory.
    * e.g. a palette named "example" would be `lua/highlite/color/palette/example.lua`.
2. Paste this template into the file:
    ```lua
    --- @type highlite.color.palette.get
    local function get(bg, get_terminal)
    	local palette, terminal_palette
    	if bg ~= 'light' then
    		if get_terminal then
    			terminal_palette = {…}
    		end

    		palette = {…}
    	else
    		if get_terminal then
    			terminal_palette = {…}
    		end

    		palette = {…}
    	end

    	return palette, terminal_palette
    end

    return get
    ```
3. Fill in the information (i.e. dark and light palettes / terminal palettes).
4. Update the `highlite.color.palette.shortname` alias in [`highlite.color.palette.types`](../lua/highlite/color/palette/types.lua) to include the new palette.

### Highlight Groups

While working on the highlight groups in this plugin, if you add support for a plugin or `:syntax` filetype, make sure that:

1. the plugin/filetype has been added [`highlite.groups.types`](../lua/highlite/groups/types.lua); and
2. the default group generator, `highlite.groups.default`, _also_ gets support for that plugin or filetype.

> **Note**
>
> The [usage guide](./advanced-usage.md#2a-overriding-groups-optional) will be helpful.

#### New Group Generator

If you would like to add a new group generator to `nvim-highlite`:

1. Create a file in the [groups](./lua/highlite/groups) directory.
    * e.g. for "highlite-example", the groups would be `lua/highlite/groups/example.lua`.
2. Paste this template into the file:
    * NOTE: feel free to change `default_groups_from_palette` to another group generator, if you'd like to base it on something else.
    ```lua
    local default_groups_from_palette = require 'highlite.groups.default' --- @type highlite.groups.from_palette
    local Groups = require 'highlite.groups' --- @type highlite.Groups
    local Options = require 'highlite.groups.options' --- @type highlite.groups.Options

    --- Generate the default highlight groups using the `palette`.
    --- @type highlite.groups.from_palette
    local function from_palette(palette, opts)
    	local all_nvim_plugins, any_nvim_plugins,
    		all_syntax, any_syntax,
    		all_vim_plugins, any_vim_plugins = Options.parse_from_palette(opts)

    	local groups = default_groups_from_palette(palette, opts)

    	--[[ override the groups. ]]

    	if any_nvim_plugins then
    		local nvim_plugins = type(opts.plugins) == 'table' and opts.plugins.nvim or {}

    		if all_nvim_plugins or nvim_plugins['PLUGIN NAME HERE'] ~= false then
    		end

    		--[[ other plgin-specific changes ]]
    	end

    	if any_vim_plugins then
    		local vim_plugins = type(opts.plugins) == 'table' and opts.plugins.vim or {}

    		if all_vim_plugins or vim_plugins['PLUGIN NAME HERE'] ~= false then
    		end

    		--[[ other plugin-specific changes ]]
    	end

    	if any_syntax then
    		local syntax = opts.syntax

    		if all_syntax or syntax['FILETYPE NAME HERE'] ~= false then
    		end

    		--[[ other filetype-specific changes ]]
    	end

    	return groups
    end

    return from_palette
    ```
3. Fill in the information necessary.
4. Remove empty `if` blocks.

### Colorschemes

If you would like to add a new colorscheme to `nvim-highlite`:

1. Create a new file named `highlite-<colorscheme>.lua` in the [colors](./colors) directory.
    * e.g. a colorscheme named "example" should be put in `colors/highlite-example.lua`.
2. Paste this template into the file:
    ```lua
    local Highlite = require 'highlite' --- @type Highlite

    local palette, terminal_palette = Highlite.palette 'PALETTE'
    Highlite.generate('highlite-COLORSCHEME_NAME', Highlite.groups('GROUPS', palette), terminal_palette)
    ```
3. Replace `COLORSCHEME_NAME` with the name of your colorscheme, `PALETTE` with the name of your chosen palette, and `GROUPS` with the name of your group generator.
    * If the palette or groups do not exist in `nvim-highlite`, you will have to create those as well.

#### Porting Colorschemes

Before covering _how_ to port a colorscheme to `nvim-highlite`, it's important to note _which_ colorschemes this project is looking for:

* __Bad:__ Modern, maintained, Lua colorschemes
* __Good:__ VimScript colorschemes, or abandoned/outdated Lua colorschemes

It is better to let colorschemes that are being maintained and updated for Neovim stay in the hands of their maintainers. Otherwise, feel free!

There is a function in the `import` module designed specifically for the purpose of automatically importing and formatting _all_ of your installed colorschemes:

```lua
--- @param ignore? {patterns: nil|string[], raw: nil|string[]} a list of colorschemes to not import. `patterns` are passed to `getcompletion`, `raw` are given literally.
--- @param repo_dir? string the path to the `nvim-highlite` repo on-disk
function Import._all_nvim_to_highlite(ignore, repo_dir)
```

* All of the built-in colorschemes (e.g. `zellner`) and this repo's colorschemes which are ported from another repo (e.g. `highlite-ayu`) are skipped by default.
* The path to the repo is inferred, but you _can_ specify it (to be safe, or if you have a second clone of this repo, etc).

For example, here is how to import all of your installed colorschemes except for `catppuccin` and a custom colorscheme:

```vim
:lua require('highlite.import')._all_nvim_to_highlite({patterns = {'catppuccin'}, raw = {'highlite-custom'}})
```

* Run `git diff` just to make sure it worked correctly.
