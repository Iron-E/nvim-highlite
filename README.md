# Introduction

`nvim-highlite` is a colorscheme template repository for Neovim 0.5+.

This project aims to make the following

* You can define/modify variables once instead of messing around with potentially botched substitutions.
* You can distribute a lean colorscheme, free from unnecessary logic.
* You can distribute the source alongside the colorscheme, making it easy for your users to experiment and adapt *your* colorscheme to *their* needs.
* You can focus on the design of your colorscheme rather than its implementation.
* You can start working on new colorscheme ideas very easily.

# Prerequisites

1. Neovim 0.5+

# Usage

Usage is simple. This repository should be cloned with `git clone https://github.com/Iron-E/nvim-highlite`, and then:

1. Rename `lua/highlite/` to `lua/<name of your colorscheme>/`.
2. Follow the directions in [lua/`<name of your colorscheme>`/init.lua](lua/highlite/init.lua).
3. Rename `colors/highlite.vim` to `colors/<name of your colorscheme>.vim`.
4. Follow the instructions in [colors/`<name of your colorscheme>`.vim](colors/highlite.vim).

## Examples

This repository in itself is an example of how to use `nvim-highlite`. Aside from this, the following colorschemes are built using `nvim-highlite`:

* (if you use this, open an issue and I'll add it here!)
