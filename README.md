# Introduction

`nvim-highlite` is a colorscheme template repository for Neovim 0.5+.

This template's focus is on compatability with [semantic highlighting](https://medium.com/@evnbr/coding-in-color-3a6db2743a1e).

It provides a large supply of defaults for plugins and programming languages as a result of defining a smaller set of "categorical" highlights (you can read more about this at Neovim's `group-name` help page).

# Prerequisites

1. Neovim 0.5+

# Usage

This repository should be cloned with `git clone https://github.com/Iron-E/nvim-highlite`, and then:

1. Rename `lua/highlite/` to `lua/<name of your colorscheme>/`.
2. Follow the directions in [lua/`<name of your colorscheme>`/init.lua](lua/highlite/init.lua).
3. Rename `colors/highlite.vim` to `colors/<name of your colorscheme>.vim`.
4. Follow the instructions in [colors/`<name of your colorscheme>`.vim](colors/highlite.vim).

## Examples

This repository in itself is an example of how to use `nvim-highlite`. Aside from this, the following colorschemes are built using `nvim-highlite`:

* (if you use this, open an issue and I'll add it here!)
