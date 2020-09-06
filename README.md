# Default Settings Preview

![lua preview](./media/preview.png "Lua Preview")

# Introduction

`nvim-highlite` is a colorscheme template repository for Neovim 0.5+.

This template's _defaults_ focus on:

1. Compatability with [semantic highlighting](https://medium.com/@evnbr/coding-in-color-3a6db2743a1e).
	* I was using colorschemes that often did not provide enough highlight groups to provide distinction between tokens.
2. Visibility in any range of blue-light.
	* I use `redshift` often, and many colorschemes did not allow for me to see when I had lower color temperatures.

This template's _design_ focuses on:

1. Ease of use and rapid development.
	* New features may simply be integrated with current configurations, rather than rewritten over them.
	* Merging with the upstream repository is simplified by GitHub, allowing you to select what new defaults to add.
	* It provides a large supply of defaults for plugins and programming languages.
		* Define a smaller set of "categorical" highlights (see Neovim's `group-name` help page) and many more will `link` automatically.
2. Inversion of Control
	* Changes made to the highlighting algorithm won't affect how you write your colorscheme.
	* New highlight group attributes which are unaccounted for in older versions will simply be ignored without errors due to Lua's `table`s.

# Prerequisites

1. Neovim 0.5+

# Usage

## Creating Your Own

1. This repository should be forked, or cloned with `git clone https://github.com/Iron-E/nvim-highlite`.
2. Follow the instructions in [`colors/highlite.vim`](colors/highlite.vim).
	* If you are on a Unix system, use the [setup script](setup.sh) like so:
	```sh
	chmod +x ./setup.sh
	./setup.sh highlite <colorscheme>
	```
	Where `<colorscheme>` is the name of your desired colorscheme.
	* If you are on Windows, rename the files manually.

## Just The Defaults

1. Install a plugin manager such as [`vim-plug`](https://github.com/junegunn/vim-plug) and use it to "plug" this repository.
	```viml
	" vim-plug example
	Plug "Iron-E/nvim-highlite"
	```
2. Specify this colorscheme as your default colorscheme in the `init.vim`:
	```viml
	" Enable 24-bit color output. Only do this if your environment supports it.
	" This plugin works 100% fine with 8-bit, 16-bit, and 24-bit colors.
	set termguicolors
	" Use the colorscheme
	colorscheme highlite
	```

## FAQ

> Why am I receiving `E5108: Error executing lua [string ":lua"]:1: module '<colorscheme>' not found`?

* Ensure your colorscheme's base folder is in Neovim's `rtp` before sourcing.

## Examples

This repository in itself is an example of how to use `nvim-highlite`. Aside from this, the following colorschemes are built using `nvim-highlite`:

* (if you use this, open an issue and I'll add it here!)

```lua
--[[Keep in mind, the following example is meant to be used within the context of the `colors/highlite.vim` file.]]
-- First, define some colors
local red = {'#FF0000', 1, 'red'}
local black = {'#000000', 0, 'black'}
local white = {'#FFFFFF', 255, 'white'}

-- Next define some highlight groups.
local highlight_groups = {
	-- Any field which can be set to "NONE" doesn't need to be set, it will be automatically assumed to be "NONE".
	Identifier = {bg=red, fg=black, style='bold'},
	-- If you want to have a colorscheme which is responsive to multiple background settings, you can do that too:
	Function = {dark={bg=black}, light={bg=white}, fg=red}
	--[[ Note that light/dark differentiation is completely optional. ]]
}

-- The rest is mostly handled by the template.
```
