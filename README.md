# nvim-highlite

## Feature Overview

* Use any of the built-in colorschemes using `:colorscheme`.
* Easily write your own colorscheme by only specifying a few colors.
* Import from formats other applications use to one that can be used with `nvim-highlite`.
* Export _any_ colorscheme (even from other repositories) to formats other applications use.

<!-- panvimdoc-ignore-start -->

## Built-in Colorschemes

<details>
  <summary>Click to expand</summary>

  <details>
    <summary><code>highlite</code> (the default)</summary>
    <img alt="highlite colorscheme lua preview" src="https://user-images.githubusercontent.com/36409591/234727053-1928ec4a-f5f2-4d7e-8fff-4c5be981722b.png"/>
  </details>

  <details>
    <summary><code>highlite-ayu</code> (based on <a href="https://github.com/ayu-theme/ayu-vim">ayu</a>)</summary>
    <img alt="ayu colorscheme Lua preview" src="https://user-images.githubusercontent.com/36409591/234727814-9613547d-4c96-4fca-8cf8-cfebcd8d9bff.png"/>
  </details>

  <details>
    <summary><code>highlite-everforest</code> (based on <a href="https://github.com/sainnhe/everforest">everforest</a>)</summary>
    <img alt="everforest colorscheme Lua preview" src="https://user-images.githubusercontent.com/36409591/234728320-e53b5d64-5a03-464a-b307-f675e46cab04.png"/>
  </details>

  <details>
    <summary><code>highlite-gruvbox</code> (based on <a href="https://github.com/morhetz/gruvbox">gruvbox</a>)</summary>
    <img alt="gruvbox colorscheme Lua preview" src="https://user-images.githubusercontent.com/36409591/234729912-003f3dec-bd0a-4de3-bd3f-9db3a5f5ca88.png"/>
  </details>

  <details>
    <summary><code>highlite-gruvbox-material</code> (based on <a href="https://github.com/sainnhe/gruvbox-material">gruvbox-material</a>)</summary>
    <img alt="gruvbox-material colorscheme Lua preview" src="https://user-images.githubusercontent.com/36409591/234728429-d4eb5892-c4d0-45ec-9301-c0a322bc31f1.png"/>
  </details>

  <details>
    <summary><code>highlite-iceberg</code> (based on <a href="https://github.com/cocopon/iceberg.vim">iceberg</a>)</summary>
    <img alt="iceberg colorscheme Lua preview" src="https://user-images.githubusercontent.com/36409591/234730354-9de2b848-cf80-42c9-b402-07fe963480c1.png"/>
  </details>

  <details>
    <summary><code>highlite-molokai</code> (based on <a href="https://github.com/tomasr/molokai">molokai</a>)</summary>
    <img alt="molokai colorscheme Lua preview" src="https://user-images.githubusercontent.com/36409591/234731452-a22447e1-530f-4016-9f1f-eceeec6aaf47.png"/>
  </details>

  <details>
    <summary><code>highlite-papercolor</code> (based on <a href="https://github.com/nlknguyen/papercolor-theme">papercolor</a>)</summary>
    <img alt="papercolor colorscheme Lua preview" src="https://user-images.githubusercontent.com/36409591/234730471-0dcbaf2f-033e-4869-bf30-8777d8e21420.png"/>
  </details>

  <details>
    <summary><code>highlite-seoul256</code> (and <code>light</code>; based on <a href="https://github.com/junegunn/seoul256.vim">seoul256</a>)</summary>
    <img alt="seoul256 colorscheme Lua preview" src="https://user-images.githubusercontent.com/36409591/234756608-8088f64d-4ce0-41a5-8eff-3b6615e15fa6.png"/>
  </details>

  <details>
    <summary><code>highlite-solarized8</code> (and <code>flat</code> and <code>high</code>; based on <a href="https://github.com/lifepillar/vim-solarized8">solarized8</a>)</summary>
    <img alt="solarized8 colorscheme Lua preview" src="https://user-images.githubusercontent.com/36409591/234731873-d61ad8f0-a738-48f6-a6f8-dd7e8ab0ddf6.png"/>
  </details>

  <details>
    <summary><code>highlite-sonokai</code> (based on <a href="https://github.com/sainnhe/sonokai">sonokai</a>)</summary>
    <img alt="sonokai colorscheme Lua preview" src="https://user-images.githubusercontent.com/36409591/234730590-1767229b-db0d-4375-9e7e-16afd4f2cc0f.png"/>
  </details>
</details>

<!-- panvimdoc-ignore-end -->

## Introduction

`nvim-highlite` is a colorscheme generator with great defaults.

The _defaults_ focuses on:

1. Compatibility with [semantic highlighting](https://medium.com/@evnbr/coding-in-color-3a6db2743a1e).
    * I was using colorschemes that often did not provide enough colors to provide distinction between tokens.
2. Visibility in any range of blue-light.
    * I use `redshift` often, and many colorschemes did not allow for me to see when I had lower color temperatures.

The _generator_ focuses on:

1. Rapid development.
    * Many times, all you need to do is pass in your colors and the highlight groups will be generated for you.
2. Utilities for working with highlight groups.
    * Clone, extend, or merge groups in order to customize what the generator creates for you.

## Installation

Requires the following:

* Neovim 0.8+

> **Note**
>
> If you don't use `termguicolors`, see [How Can I Get This Plugin To Work _Without_ `termguicolors`?][no-guicolors]

### lazy.nvim

I recommend using [lazy.nvim][lazy]:

```lua
require('lazy').setup {
  {'Iron-E/nvim-highlite',
    config = function(_, opts)
      -- OPTIONAL: setup the plugin. See "Configuration" for information
      require('highlite').setup {generator = {plugins = {vim = false}, syntax = false}}

      -- or one of the alternate colorschemes (see the "Built-in Colorschemes" section)
      vim.api.nvim_command 'colorscheme highlite'
    end,
    lazy = false,
    priority = 1000,
    version = '^4.0.0',
  },
}
```

### Others

1. Install a plugin manager such as [`packer.nvim`](https://github.com/wbthomason/packer.nvim):
    ```lua
    -- packer.nvim example
    local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

    if not vim.loop.fs_stat(vim.fn.glob(install_path)) then
      vim.fn.system {'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path}
    end

    vim.api.nvim_command 'packadd packer.nvim'

    return require('packer').startup {function(use)
      use {'wbthomason/packer.nvim', opt = true}
      use {'Iron-E/nvim-highlite', branch = 'master-v4'}
    end}
    ```
2. Optional – setup the plugin (see [Configuration](#configuration) for more info):
    ```lua
    require('highlite').setup {generator = {plugins = {vim = false}, syntax = false}}
    ```
3. Specify this colorscheme as your default colorscheme:
    ```lua
    vim.api.nvim_command 'colorscheme highlite'
    ```

## Configuration

You can configure what highlight groups get generated for both built-in and your custom colorschemes. Do this by calling `setup` _before_ executing `:colorscheme` for any colorscheme created with `nvim-highlite`.

The available options are explained in the following sections. Note that the more you *dis*able, the faster your startup time will be.

### Generator

Controls what highlight groups get created by the plugin.

> **Note**
>
> All integrations are enabled by default, and the `setup` table accepts a deny list. If you instead want to use an allow list, you can do something like this instead:
>
> ```lua
> local allow_list = {__index = function() return false end}
> require('highlite').setup {
>   generator = {
>     plugins = {
>       nvim = {packer = false}, -- use all but packer
>       vim = setmetatable({coc = true}, allow_list), -- only use `coc`
>     },
>     syntax = setmetatable({man = true}, allow_list), -- only use `man` sytnax highlighting
>   },
> }
> ```

#### Plugins

Controls generating highlighting for plugins. You can disable all integrations:

```lua
require('highlite').setup {generator = {plugins = false}}
```

…or, to disable specific plugins, see [Neovim](#neovim) and [Vim](#vim).

##### Neovim

Controls generation for neovim plugins. You can disable all neovim plugin integrations:

```lua
require('highlite').setup {
  generator = {
    plugins = {nvim = false},
  },
}
```

…or, to disable generation for certain plugins:

```lua
require('highlite').setup {
  generator = {
    plugins = {nvim = {packer = false}},
  },
}
```

###### List of Neovim Plugins

<details>

<!-- panvimdoc-ignore-start -->

  <summary>Click to expand</summary>

<!-- panvimdoc-ignore-end -->

  <ul>
    <li><a href="https://github.com/romgrk/barbar.nvim">
      barbar
    </a></li>
    <li><a href="https://github.com/kevinhwang91/nvim-bqf">
      bqf
    </a></li>
    <li><a href="https://github.com/hrsh7th/nvim-cmp/">
      cmp
    </a></li>
    <li><a href="https://github.com/ibhagwan/fzf-lua">
      fzf_lua
    </a></li>
    <li><a href="https://github.com/lewis6991/gitsigns.nvim">
      gitsigns
    </a></li>
    <li><a href="https://github.com/lukas-reineke/indent-blankline.nvim">
      indent_blankline
    </a></li>
    <li><a href="https://github.com/folke/lazy.nvim">
      lazy
    </a></li>
    <li><a href="https://github.com/neovim/nvim-lspconfig">
      lspconfig
    </a></li>
    <li><a href="https://github.com/nvimdev/lspsaga.nvim">
      lspsaga
    </a></li>
    <li><a href="https://github.com/ray-x/lsp_signature.nvim">
      lsp_signature
    </a></li>
    <li><a href="https://github.com/echasnovski/mini.nvim">
      mini
    </a></li>
    <li><a href="https://github.com/nvim-neo-tree/neo-tree.nvim">
      neo_tree
    <li><a href="https://github.com/nvim-tree/nvim-tree.lua">
      nvim_tree
    </a></li>
    <li><a href="https://github.com/wbthomason/packer.nvim">
      packer
    </a></li>
    <li><a href="https://github.com/tversteeg/registers.nvim">
      registers
    </a></li>
    <li><a href="https://github.com/simrat39/symbols-outline.nvim">
      symbols_outline
    </a></li>
    <li><a href="https://github.com/folke/todo-comments.nvim">
      todo_comments
    </a></li>
    <li><a href="https://github.com/folke/trouble.nvim">
      trouble
    </a></li>
  </ul>
</details>

##### Vim

Controls generation for vim plugins. You can disable all vim plugin integrations:

```lua
require('highlite').setup {
  generator = {
    plugins = {vim = false},
  },
}
```

…or, to disable generation for certain plugins:

```lua
require('highlite').setup {
  generator = {
    plugins = {vim = {ale = false}}
  },
}
```

###### List of Vim Plugins

<details>

<!-- panvimdoc-ignore-start -->

  <summary>Click to expand</summary>

<!-- panvimdoc-ignore-end -->

  <ul>
    <li><a href="https://github.com/dense-analysis/ale">
      ale
    </a></li>
    <li><a href="https://github.com/neoclide/coc.nvim">
      coc
    </a></li>
    <li><a href="https://github.com/kristijanhusak/vim-dadbod-ui">
      dadbod_ui
    </a></li>
    <li><a href="https://github.com/easymotion/vim-easymotion">
      easymotion
    </a></li>
    <li><a href="https://github.com/lambdalisue/fern.vim">
      fern
    </a></li>
    <li><a href="https://github.com/airblade/vim-gitgutter">
      gitgutter
    </a></li>
    <li><a href="https://github.com/thaerkh/vim-indentguides">
      indent_guides
    </a></li>
    <li><a href="https://github.com/zsugabubus/vim-jumpmotion">
      jumpmotion
    </a></li>
    <li><a href="https://github.com/preservim/nerdtree">
      nerdtree
    </a></li>
    <li><a href="https://github.com/machakann/vim-sandwich">
      sandwich
    </a></li>
    <li><a href="https://github.com/mhinz/vim-signify">
      signify
    </a></li>
    <li><a href="https://github.com/machakann/vim-swap">
      swap
    </a></li>
    <li><a href="https://github.com/mbbill/undotree">
      undotree
    </a></li>
    <li><a href="https://github.com/dstein64/vim-win">
      win
    </a></li>
  </ul>
</details>

#### Syntax

Controls generating legacy syntax highlighting. You can disable generation for all filetypes:

```lua
require('highlite').setup {
  generator = {syntax = false},
}
```

…or, to disable generation for certain filetypes:

```lua
require('highlite').setup {
  generator = {
    syntax = {dosini = false, git = false},
  },
}
```

> **Note**
>
> Treesitter highlighting is always enabled. You can safely disable `:syntax` highlighting if you only use treesitter.

##### List of Syntax Filetypes

<details>

<!-- panvimdoc-ignore-start -->

  <summary>Click to expand</summary>

<!-- panvimdoc-ignore-end -->

  <ul>
    <li><a href="https://github.com/whonore/Coqtail">
      coq
    </a></li>
    <li><a href="https://github.com/bfrg/vim-cpp-modern">
      cpp
    </a></li>
    <li>
      cs
    </li>
    <li>
      css
    </li>
    <li><a href="https://github.com/dart-lang/dart-vim-plugin">
      dart
    </a></li>
    <li>
      dosini
    </li>
    <li><a href="https://github.com/liuchengxu/graphviz">
      dot
    </a></li>
    <li><a href="https://github.com/tpope/vim-git">
      git
    </a></li>
    <li><a href="https://github.com/fatih/vim-go">
      go
    </a></li>
    <li>
      help
    </li>
    <li><a href="https://github.com/othree/html5">
      html
    </a></li>
    <li><a href="https://github.com/mboughaba/i3config">
      i3config
    </a></li>
    <li><a href="https://github.com/uiiaoo/java-syntax">
      java
    </a></li>
    <li><a href="https://github.com/pangloss/vim-javascript">
      javascript
    </a></li>
    <li><a href="https://github.com/elzr/vim-json">
      json
    </a></li>
    <li><a href="https://github.com/tbastos/vim-lua">
      lua
    </a></li>
    <li>
      make
    </li>
    <li>
      man
    </li>
    <li><a href="https://github.com/plasticboy/vim-markdown">
      markdown
    </a></li>
    <li><a href="https://github.com/vim-python/python-syntax">
      python
    </a></li>
    <li><a href="https://github.com/jlcrochet/vim-razor">
      razor
    </a></li>
    <li><a href="https://github.com/vim-ruby/vim-ruby">
      ruby
    </a></li>
    <li><a href="https://github.com/Iron-E/rust.vim/tree/feature/struct-definition-identifiers">
      rust
    </a></li>
    <li>
      scala
    </li>
    <li><a href="https://github.com/cakebaker/scss-syntax">
      scss
    </a></li>
    <li><a href="https://github.com/arzg/vim-sh">
      sh
    </a></li>
    <li>
      solidity
    </li>
    <li><a href="https://github.com/shmup/vim-sql-syntax">
      sql
    </a></li>
    <li><a href="https://github.com/lervag/vimtex">
      tex
    </a></li>
    <li><a href="https://github.com/Iron-E/vim-toml/tree/feature/delimiter-highlighting">
      toml
    </a></li>
    <li>
      vim
    </li>
    <li>
      xdefaults
    </li>
    <li><a href="https://github.com/amadeus/vim-xml">
      xml
    </a></li>
    <li>
      xxd
    </li>
    <li><a href="https://github.com/Iron-E/vim-yaml/tree/patch-1">
      yaml
    </a></li>
  </ul>
</details>

### Terminal Palette

Colors for Neovim's `:terminal` are automatically set for all built-in colorschemes (see `:h terminal-config`). To disable this, do the following:

```lua
require('highlite').setup {terminal_palette = false}
```

## Usage

### Built-in Colorschemes

To use one of the built-in colorschemes, simply do:

```lua
vim.api.nvim_command 'colorscheme <name>'
```

> **Warning**
>
> If you _want_ to configure this plugin, make sure you do so before executing `:colorscheme`! See [Configuration](#configuration) for more.

### Exporting Colorschemes

> **Note**
>
> This specific feature requires Neovim 0.9+

This plugin has the ability to export _any_ colorscheme (not just ours!) to various formats, including:

* `nvim` theme (Lua)
* `vim` theme (Vimscript)
* `wezterm` theme (TOML)

To make use of this, just run this after installing the plugin:

```lua
require('highlite.export').<format>(
  '<colorscheme name>',
  -- all options below are OPTIONAL
  {
    -- controls the directory where the exported colorscheme will be written.
    dir = '~/.config/nvim/colors/',

    -- controls the name of the file that is created, as well as the name of the
    -- output colorscheme.
    filename = 'foo',

    -- if `false`, an existing target file will not be overwritten. Instead, a
    -- file with a similar name will be created.
    force = true,

    -- if `true`, the function will not notify you when it is finished.
    silent = false,
  }
)
```

If your plugin manager supports update hooks (e.g. `lazy.nvim`, `packer.nvim`, `vim-plug`) you can run this function whenever a given colorscheme plugin updates.

For example, to generate a Wezterm theme from [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) whenever it updates, you can do something like this (example for [lazy.nvim][lazy]):

```lua
{'folke/tokyonight.nvim',
  build = function() require('highlite.export').wezterm('tokyonight', {force = true}) end,
  config = function() vim.api.nvim_command 'colorscheme tokyonight' end,
  dependencies = 'Iron-E/nvim-highlite',
  priority = 1000,
}
```

> **Warning**
>
> If you use `lazy.nvim`'s `build` option to export colorschemes, it is possible that the background color might not export correctly. See folke/lazy.nvim#753 for details and a workaround.

### Importing/Writing Colorschemes

To create your own colorscheme, or import an existing one, see [the advanced usage guide][usage].

## Contribution

See the [contributing guide][contributing].

## Limitations

### `cterm` Colors

The generator, for simplicity and speed purposes, does not include `cterm` highlight groups. This was also partially motivated by a [survey of configurations](https://gist.github.com/echasnovski/fa70dc75c475369747d2a485a13303fb). However, you _can_ make this plugin work with `cterm` colors! See [How Can I Get This Plugin To Work _Without_ `termguicolors`?][no-guicolors]

### Generated Terminal Palettes

While `nvim-highlite` _provides_ terminal palettes for all built-in colorschemes, `nvim-highlite` cannot _generate_ new terminal palettes because of the difference in how terminal palettes and `nvim-highlite`'s palletes are defined:

* terminal palettes are created specifying the RGB color value of specific color names (e.g. "red" = "#FF0000"), and
* `nvim-highlite`'s palettes are defined by assigning an RGB color value to semantic categories (e.g. `keyword` = "#4422AA").

This is a problem because there is no association between token types (e.g. `error`, `func`) and the color value (e.g. "#A80000", "#CF55F0"). Thus, there's no *performant* way to assign a color to e.g. "red".

See [Creating A Terminal Palette](./doc/advanced-usage.md#1b-creating-a-terminal-palette-optional) for a tutorial on how to write one yourself, or [mini.colors][mini.colors] for a supplementary plugin that can generate this palette for you.

## FAQ

### "How can I get this plugin to work _without_ `termguicolors`?"

You can use [mini.colors][mini.colors]— it will infer a cterm palette based on the GUI colors from _any_ colorscheme.

To use it, do this instead of `:colorscheme <name>`:

```lua
-- replace `<name>` with the name of any of the builtin colorschemes
require('mini.colors').get_colorscheme('<name>'):add_cterm_attributes():apply()
```

If your plugin manager has update hooks (e.g. vim-plug, packer.nvim, lazy.nvim) you can save performance by doing the above _once_ every update. Here is an example for [lazy.nvim][lazy]:

```lua
{'Iron-E/nvim-highlite',
  build = function()
    require('mini.colors')
      -- replace `<name>` with the name of any of the builtin colorschemes
      .get_colorscheme('<name>', {new_name = 'my-custom-colorscheme'})
      :add_cterm_attributes()
      :write()
  end,
  config = function() vim.api.nvim_command 'colorscheme my-custom-colorscheme' end,
  dependencies = 'echasnovski/mini.colors',
  priority = 1000,
}
```

> **Warning**
>
> If you use `lazy.nvim`'s `build` option to export colorschemes, it is possible that the background color might not export correctly. See folke/lazy.nvim#753 for details and a workaround.

### "How can I override highlights in my `init.lua`?"

You can either write your own colorscheme, or add an `autocmd` to your config. Both have merits: a custom colorscheme has better performance, but an `autocmd` will work with multiple colorschemes (if you like to switch between them).

> **Note**
>
> For information about creating your own colorscheme, see [the docs][usage].

You can add an `autocmd` to your config like this:

```lua
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.api.nvim_set_hl(0, 'Error', {fg = '#000000', bg = '#FFFFFF'})
    -- other groups
  end,
  group = vim.api.nvim_create_augroup('config', {clear = true}),
  pattern = 'highlite', -- apply to just the highlite colorscheme
  -- pattern = {'highlite', 'tokyonight'}, -- apply to highlite and tokyonight
  -- pattern = '*', -- apply to all colorschemes
})

-- WARN: make sure the colorscheme gets loaded AFTER setting the autocommand!
vim.api.nvim_command 'colorscheme highlite'
```

Of course, substitute `highlite` with the name of your colorscheme.

<!-- panvimdoc-ignore-start -->

### "How does this compare to `XYZ` plugin?"

It doesn't seem right as a plugin author to weigh the benefits of others' work. Instead, here are some facts notable about `nvim-highlite`:

* You only need 6 colors to create a colorscheme, but you can use as many as you want.
    * Want to use 1,000 colors? Go for it.
* _Great_ effort has been taken to reduce the startup cost of this plugin.
* While our semantic color palette prevents _generating_ a terminal palette, it makes creating a new colorscheme easier.
    * __Remember:__ all built-in colorschemes come with a terminal palette.
* This plugin can import any colorscheme written in a language Neovim supports, and give it support for the latest highlights.
    * VimScript colorschemes usually become faster when ported, and sometimes Lua colorschemes do too.
    * Contributors can use specially-made internal tools which automate certain development tasks.
* This plugin provides a great starting point for a custom colorscheme:
    * all of the built-in highlight groups;
    * diagnostics, LSP, treesitter;
    * custom support for 20+ plugins (not counting ones that work out of the box); and
    * custom support for 30+ filetypes (not counting ones that work out of the box).
* If something isn't to your liking, there are many tools for the purpose of customizing what is provided.
  * The syntax is familiar, simple, orthogonal, and completely stable.

If this plugin doesn't suit your needs, here is a list of excellent alternatives:

* [echasnovski/mini.base16](https://github.com/echasnovski/mini.base16)
* [rktjmp/lush.nvim](https://github.com/rktjmp/lush.nvim)
* [themercorp/themer.lua](https://github.com/themercorp/themer.lua)

### "What font is that in the screenshots?"

JetBrains Mono.

<!-- panvimdoc-ignore-end -->


```{.include}
./doc/advanced-usage.md
./doc/contributing.md
```

[built-in-colorschemes]: #built-in-colorschemes
[contributing]: ./doc/contributing.md
[lazy]: https://github.com/folke/lazy.nvim
[mini.colors]: https://github.com/echasnovski/mini.colors
[no-guicolors]: #how-can-i-get-this-plugin-to-work-without-termguicolors
[usage]: ./doc/advanced-usage.md
