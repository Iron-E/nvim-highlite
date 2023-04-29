# Advanced Usage

Welcome to the advanced usage guide for `nvim-highlite`! This will teach you how to create your own colorscheme using this plugin, whether it be from scratch, one of our built-in colorschemes, or another existing colorscheme.

## tl;dr

* [Create a Colorscheme](#complete-example)
* [Import a Colorscheme](#importing-colorschemes)

## Concepts

Before jumping straight into [Creating Your Colorscheme](#creating-your-colorscheme), it is important to know about the *concepts* which `nvim-highlite` is designed around. There are several terms which you will see:

### Color

**Color**s in `nvim-highlite` can be either:

* a hex color string, e.g. `"#ffffff"`; or
* an integer in base 10 which converts to a hex color string in base 16, e.g. `0xFFFFFF`.

> **Note**
>
> Lua can easily convert between both formats:
>
> ```lua
> assert("ffffff" == bit.tohex(0xFFFFFF, 6))
> assert(0xFFFFFF == tonumber("ffffff", 16))
> ```

### Palette

A **palette** is a semantic collection of **color**s. For example:

```lua
{
  bg = '#000000',
  bg_contrast_high = '#404040',
  bg_contrast_low = '#202020',

  text = '#cdcdcd',
  text_dark = '#aaaaaa',
  text_light = '#ffffff',
}
```

#### List of Palette Colors

> **Note**
>
> You do *not* need to assign all of these! You can define a small number of them, a full palette will be created (see [Deriving a Palette][deriving-a-palette]).

| Field                   | Definition                                                                              |
|:------------------------|:----------------------------------------------------------------------------------------|
| `annotation`            |                                                                                         |
| `attribute`             |                                                                                         |
| `bg`                    | the background color                                                                    |
| `bg_contrast_high`      | an accent to the `bg` color which contrasts                                             |
| `bg_contrast_low`       | an accent to the `bg` color which barely contrasts                                      |
| `boolean`               | `true` and `false`                                                                      |
| `buffer_active`         | the underline of an active buffer                                                       |
| `buffer_alternate`      | the underline of the alternate buffer                                                   |
| `buffer_current`        | the underline of the current buffer                                                     |
| `character`             | character literals (e.g. `'a'`)                                                         |
| `character_special`     | special characters e.g. wildcards                                                       |
| `class`                 | data with behavior                                                                      |
| `comment`               | normal comments                                                                         |
| `comment_documentation` | documentation comments                                                                  |
| `comment_special`       | special tokens in a comment                                                             |
| `conditional`           | e.g. `if`, `match`, `switch`                                                            |
| `constant`              | constant values                                                                         |
| `constant_builtin`      | built-in constant values                                                                |
| `constructor`           | invoked by `new`                                                                        |
| `decorator`             |                                                                                         |
| `define`                | e.g. `#define` in C                                                                     |
| `diff_add`              | added text                                                                              |
| `diff_change`           | changed text, also applies to modified buffers in the tabline                           |
| `diff_delete`           | removed text                                                                            |
| `enum`                  | an enumeration                                                                          |
| `error`                 | diagnostic errors                                                                       |
| `event`                 | events e.g. `public event FooEventHandler FooEvent` in C#                               |
| `field`                 | a member of a class/struct which is accessed directly                                   |
| `field_enum`            | a variant of an enum e.g. `Ok` in Rust                                                  |
| `float`                 | floating point numbers                                                                  |
| `fold`                  | the background of `&foldtext`                                                           |
| `func`                  | functions, e.g. `print('a')`                                                            |
| `func_builtin`          | builtin function                                                                        |
| `hint`                  | diagnostic hints                                                                        |
| `identifier`            | misc. identifier                                                                        |
| `include`               | e.g. `#include` in C                                                                    |
| `info`                  | diagnostic info                                                                         |
| `interface`             | e.g. `interface Foo`                                                                    |
| `keyword`               | keywords, e.g. `local` in Lua                                                           |
| `keyword_coroutine`     | e.g. `await`                                                                            |
| `keyword_function`      | e.g. `fn` in Rust, `def` in Python                                                      |
| `keyword_operator`      | e.g. `and` in Lua                                                                       |
| `keyword_return`        | e.g. `return`, `yield`                                                                  |
| `label`                 | switch cases, loop labels (e.g. `'outer for x in y { break 'outer }` in Rust)           |
| `loop`                  | e.g. `loop`, `for`, `while`                                                             |
| `macro`                 | e.g. `println!` in Rust                                                                 |
| `message`               | Builtin Vim messages                                                                    |
| `method`                | function of a class                                                                     |
| `namespace`             | e.g. `foo::bar` in Rust/C++                                                             |
| `number`                | number literals (e.g `9`)                                                               |
| `ok`                    | positive reinforcement from LSP or Git                                                  |
| `operator`              | e.g. `+`, `-`, `&&`                                                                     |
| `parameter`             | a function parameter                                                                    |
| `preproc`               | pre-processor commands (e.g. `#[derive]` in Rust)                                       |
| `preproc_conditional`   | pre-processor conditionals (e.g. `#[cfg]` in Rust)                                      |
| `property`              | a member of a class or structure which is transparently a function                      |
| `punctuation`           | misc. delimiters                                                                        |
| `punctuation_bracket`   | balanced punctuation, e.g. `[]`, `""`, `()`                                             |
| `punctuation_delimiter` | single punctuation, e.g. `,`, `;`                                                       |
| `punctuation_special`   | special punctuation, e.g. `{}` in a format string                                       |
| `search`                | Doing `:/` or `:s/`                                                                     |
| `select`                | selected text, e.g. in visual mode or selecting LSP completions                         |
| `special`               | unclassified special symbols in a language                                              |
| `statement`             | programming language statements which do not fall into another category                 |
| `storage`               | pointer symbols (e.g. `&foo`)                                                           |
| `string`                | a misc. string                                                                          |
| `string_escape`         | escaped characters in a string                                                          |
| `string_regex`          | regular expressions                                                                     |
| `string_special`        | special strings (e.g. dates)                                                            |
| `structure`             | plain-old data                                                                          |
| `syntax_error`          | non-diagnostic errors; sometimes shown in the actual highlighting of the code you write |
| `tag`                   | XML/HTML tags                                                                           |
| `tag_attribute`         | XML/HTML tag attributes                                                                 |
| `tag_delimiter`         | `<`/`>` in XML/HTML tags                                                                |
| `text`                  | plaintext                                                                               |
| `text_contrast_bg_high` | an accent to the `text` color which contrasts                                           |
| `text_contrast_bg_low`  | an accent to the `text` color which barely contrasts                                    |
| `text_literal`          | literal text                                                                            |
| `text_reference`        | references to variables in text                                                         |
| `throw`                 | a keyword which triggers or receives errors (e.g. `throw MyError`)                      |
| `todo`                  | `TODO` comments                                                                         |
| `type`                  | type names e.g. `int`, `String`                                                         |
| `type_builtin`          | a type from the standard library                                                        |
| `type_parameter`        | generic type                                                                            |
| `uri`                   | links (HTTP, tags, match paren, etc).                                                   |
| `variable`              | a variable                                                                              |
| `variable_builtin`      | a variable from the language, e.g. `self`                                               |
| `warning`               | diagnostic warnings                                                                     |

### Highlight Groups

A **Group** is a collection of attributes, based on a **palette**, which defines how certain types of text look. Follows the format of `nvim_set_hl`'s `{val}` parameter. Example:

```lua
local colors = require('highlite.color.palette').derive(…) -- see "Deriving a Palette" for more info
local normal = {fg = colors.text, bg = colors.bg}
```

`nvim-highlite` also accepts a shorthand `:highlight link` syntax:

```lua
local float = 'Number' -- same as `{link = 'Number'}`
```

## Creating Your Colorscheme

At last, you are ready to create a colorscheme! You should follow these sections in order to ensure your success.

### Where to Put Your Colorscheme

Colorschemes must be defined in a very specific location in order to be visible to Neovim's `:colorscheme` command. In order for `:colorscheme foo` to work, there must be a `colors/foo.vim` or `colors/foo.lua` file located within your `&runtimepath`.

> **Note**
>
> To check your runtime path, do `lua for _, p in ipairs(vim.opt.rtp:get()) do print(p) end`.

#### Personal Colorscheme

If you are making this colorscheme for yourself, that file should be in your configuration directory. Run this snippet to show where that is:

```lua
:lua = vim.fn.stdpath('config') .. '/colors/'
```

#### Re-distributable Colorscheme

If you are making this colorscheme for others to be able to install— first, consider [contributing](./contributing.md)! I'd love to have more colorschemes built-in with this repository.

If you'd rather have the colorscheme live separately from this repository, create a repository and `git clone https://github.com/YOUR_USERNAME/YOUR_REPO YOUR_PROGRAMMING_DIR/YOUR_REPO`. You can then use a plugin manager to load this directory— here is an example for [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
require('lazy').setup(
  {
    {'YOUR_USERNAME/YOUR_REPO',
      config = function() vim.api.nvim_command 'colorscheme YOUR_COLORSCHEME' end,
      dependencies = 'Iron-E/nvim-highlite',
      priority = 1000,
    },
  },
  {dev = {fallback = true, path = 'YOUR_PROGRAMMING_DIR', patterns = {'YOUR_USERNAME'}}}
)
```

Make sure to replace `YOUR_COLORSCHEME`, `YOUR_PROGRAMMING_DIR`, `YOUR_REPO`, `YOUR_USERNAME` with what those values would actually be.

### 1. Generating a Palette

Now that [your file has been created](#0-creating-a-file), you can start developing your colorscheme. The first thing to do is decide on your palette: will base it off of one that is built-in, or create a new one?

* If you like the look of one of the built-in colorschemes, you should use one of the built-in palettes.
* If you want to make a new colorscheme, or port another colorscheme over to `highlite`, you should derive it.

#### Deriving a Palette

There are currently 40+ fields to a palette, and that number will probably only grow over time. To make the process of creating a palette for `nvim-highlite` easier, there is `Palette.derive`. Using this function, only 6(!!) colors need to be defined:

```lua
local Palette = require 'highlite.color.palette' --- @type highlite.color.Palette
local colors = Palette.derive('dark', {
  bg = '#202020',
  error = '#aa0000',
  ok = '#00aa00',
  text = '#cccccc',
  statement = '#33ccFF',
  storage = '#cc7700',
})
```

Of course… that means your colorscheme only uses six colors. Even though only those six are *required*, it is *recommended* to define more. With more information, `derive` becomes more accurate. Some groups that are *recommended* are:

* `func`
* `hint` (& `info`, if you want them be distinct from `hint`s)
* `uri`
* `warning`

Here is another example showing all of the above, which includes detection of light/dark backgrounds:

```lua
local Palette = require 'highlite.color.palette' --- @type highlite.color.Palette

local bg = vim.api.nvim_get_option 'background'
local colors = Palette.derive(bg, bg == 'dark' and {
  bg = '#202020',
  error = '#aa0000',
  func = '#cc00aa',
  hint = '#cc0055',
  info = '#ccbb88',
  ok = '#33bb55',
  statement = '#33ccFF',
  storage = '#cc7700',
  text = '#cccccc',
  uri = '#00aa00',
  warning = '#ffbb00',
} or {
  -- light palette goes here
})
```

##### 1b. Creating a Terminal Palette (Optional)

To define a terminal palette, all you have to do is define a list with colors in the following order:

1. black
2. dark red
3. dark green
4. dark yellow / orange
5. blue
6. dark magenta
7. dark cyan
8. gray / "dark white"
9. dark gray / "light black"
10. red
11. green
12. yellow
13. light blue
14. magenta
15. cyan
16. white

For example:

```lua
local terminal_palette = {
  '#101017', '#aa0000', '#33bb55', '#cc7700', '#133099', '#990066', '#33ccFF', '#cccccc',
  '#808080', '#FF2222', '#00aa00', '#7f6f20', '#1259ff', '#cc00aa', '#3388aa', '#ffffff',
}
```

#### Using a Built-in Palette

```lua
local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'highlite' -- or any of the built-in palettes, e.g. 'ayu'
```

The `terminal_palette` will automatically be `nil` when you turn off terminal highlighting in `setup`.

##### List of Built-in Palettes

| Name               | Description                                                                   |
|:-------------------|:------------------------------------------------------------------------------|
| `ayu`              | Based on `ayu` from [ayu-theme/ayu-vim][ayu]                                  |
| `everforest`       | Based on `everforest` from [sainnhe/everforest][everforest]                   |
| `gruvbox-material` | Based on `gruvbox-material` from [sainnhe/gruvbox-material][gruvbox-material] |
| `gruvbox`          | Based on `gruvbox` from [morhetz/gruvbox][gruvbox]                            |
| `highlite`         | The original `nvim-highlite` palette                                          |
| `iceberg`          | Based on `iceberg` from [cocopon/iceberg.vim][iceberg]                        |
| `molokai`          | Based on `molokai` from [tomasr/molokai][molokai]                             |
| `papercolor`       | Based on `papercolor` from [nlknguyen/papercolor-theme][papercolor]           |
| `seoul256-light`   | Based on `seoul256-light` from [junegunn/seoul256.vim][seoul256]              |
| `seoul256`         | Based on `seoul256` from [junegunn/seoul256.vim][seoul256]                    |
| `solarized8-flat`  | Based on `solarized8-flat` from [lifepillar/vim-solarized8][solarized]        |
| `solarized8-high`  | Based on `solarized8-high` from [lifepillar/vim-solarized8][solarized]        |
| `solarized8-low`   | Based on `solarized8-low` from [lifepillar/vim-solarized8][solarized]         |
| `solarized8`       | Based on `solarized8` from [lifepillar/vim-solarized8][solarized]             |
| `sonokai`          | Based on `sonokai` from [sainnhe/sonokai][sonokai]                            |

#### `highlite.Color` Reference

> **Note**
>
> This section is *optional*. Both `Palette.derive` and the built-in palettes handle colors automatically. However, if you wish to have finer control, you may use these functions.

##### `Color.saturate()`

```lua
function Color.saturate(color: integer|string, factor: integer) -> integer
```

Saturates the given `color` multiplicatively using `factor`. Example:

```lua
local Color = require 'highlite.color' --- @type highlite.Color

assert(Color.saturate('#202020', 2) == 0x404040)
assert(Color.saturate(0x202020, 0.5) == 0x101010)
```

### 2. Generating Groups

To generate groups, you can do:

```lua
local Highlite = require 'highlite' --- @type Highlite

local palette = … -- derive or get a built-in palette
local groups = Highlite.groups('default', palette) -- or any of the built-in groups
```

#### List of Built-in Groups

| Name               | Description                                                    |
|:-------------------|:---------------------------------------------------------------|
| `default`          | The default groups: all Neovim built-ins and some Lua plugins. |

#### 2a. Overriding Groups (Optional)

`nvim-highlite` provides utility for overriding the groups which it generates. Most of these are documented in the [`highlite.Groups` reference](#highlitegroups-reference), but there is one other utility which is notable:

```lua
local palette = … -- see instructions for generating a palette
local groups = … -- see above instructions for generating groups

-- create a new highlight group `Foo`
groups.Foo = {fg = palette.text}

-- link `Bar` to `Foo`
groups.Bar = 'Foo'

-- `groups.XYZ` will retrieve `XYZ`'s raw value.
assert(vim.deep_equal(groups.Foo, {fg = palette.text}))
assert(vim.deep_equal(groups.Bar, 'Foo'))

-- `groups'XYZ'` will retrieve `XYZ`'s unlinked value
assert(vim.deep_equal(groups'Foo', {fg = palette.text}))
assert(vim.deep_equal(groups'Bar', {fg = palette.text}))

--[[ You can use this to choose whether to reference a link or a definition. ]]

-- link 'Baz' to 'Foo', since 'Bar' is linked to 'Foo' too
groups.Baz = groups.Bar

-- create a new highlight group `Xyz` using `Bar`'s unlinked `fg` attribute
groups.Xyz = {fg = groups'Bar'.fg}
```

##### `highlite.Groups` Reference

> **Note**
>
> This section is *optional*. Feel free to use `vim.deepcopy`, `vim.tbl_extend`, etc. and come back later if you feel like you need more performance.

Working with raw highlight groups can be slow using built-in methods.

For example, let's say we want to highlight Lua's `[[`/`]]` delimiters differently than normal delimiters. How would you do that normally?

```lua
local delimiter = {fg = '#FFFFFF'}
local lua_delimiter = vim.tbl_extend('keep', {italic = true}, delimiter)
```

Using the `Bench` function [in my config](https://gitlab.com/Iron_E/dotfiles/-/blob/e47244fd6fac838a6e7848d2d36014f9cea04629/.config/nvim/lua/init/config.lua#L180), you can determine that this is ⪆4× faster:

```lua
local delimiter = {fg = '#FFFFFF'}
local lua_delimiter = Groups.extend({italic = true}, delimiter)
```

All of the functions in `Groups` are specialized for working with highlight groups; they can be minimal in ways which built-in functions should not be. You should prefer to use these functions, where they apply.

> **Warning**
>
> None of the following functions work with the shorthand link syntax:
>
> ```lua
> local Groups = require 'highlite.groups' --- @type highlight.Groups
> local DiagnosticError = 'Error'
> local cloned = Groups.clone(DiagnosticError) -- invalid!
> ```
>
> There is a way to resolve highlight links into a valid group definition— see [Overriding Groups](#2a-overriding-groups-optional).

###### `Groups.clone()`

```lua
function Groups.clone(group: table<string, any>) -> table<string, any>
```

Return a new highlight group definition with the same attributes of some `group`.

> **Perf**
>
> Faster than `vim.deepcopy` for the case of copying highlight groups.

Example:

```lua
local Groups = require 'highlite.groups' --- @type highlite.Groups

local delimiter = {fg = '#FFFFFF'}
local err = {fg = '#c0c0c0', bg = '#aa0000'}
local err_delimiter = Groups.extend(Groups.clone(delimiter), err)

assert(not vim.deep_equal(delimiter, delimiter_clone))
```

###### `Groups.extend()`

```lua
function Groups.extend(child: table<string, any>, parent: table<string, any>)
  -> table<string, any>
```

Assign all attributes of `parent` to `child` which are not already defined.

> **Perf**
>
> Faster than `vim.tbl_extend` for the case of extending highlight groups.

> **Warning**
>
> This mutates `child`! Use `Groups.clone()` first if this is a problem.

Example:

```lua
local Groups = require 'highlite.groups' --- @type highlite.Groups

local char = {fg = '#FF0000'}
local special_char = Groups.extend({italic = true}, char)
```

###### `Groups.extend_selected()`

```lua
function Groups.extend_selected(
  child: table<string, any>,
  parent: table<string, any>,
  opts: table<string, boolean>
) -> table<string, any>
```

Like `Groups.extend`, but allows forcing and skipping attributes. Example:

```lua
local Groups = require 'highlite.groups' --- @type highlite.Groups

local white_bold = {fg = '#FFFFFF', bold = true}
local green_red_italic = {fg = '#00FF00', bg = '#FF0000', bold = false, italic = true}
local white_red_italic = Groups.extend_selected(green_red_italic, white_bold_text, {fg = true})
local green_red_bold_italic = Groups.extend_selected(green_red_italic, white_bold_text, {bold = true, fg = false})
```

> **Perf**
>
> Faster than `vim.tbl_extend`ing the output of `vim.tbl_filter` for the case of extending highlight groups.

> **Warning**
>
> This mutates `child`! Use `Groups.clone()` first if this is a problem.


### 3. Setup

Finally, now that you have your **palette** and your **groups**, you can setup your colorscheme:

```lua
require('highlite').setup(
  '<name>', -- replace `<name>` with the name of the file you created in step 1
  groups,
  terminal_palette -- OPTIONAL: set the terminal colors
)
```

### Complete Example

```lua
local Groups = require 'highlite.groups' --- @type highlite.Groups
local Highlite = require 'highlite' --- @type Highlite
local Palette = require 'highlite.color.palette' --- @type highlite.color.Palette

--[[ Generate Palette
  NOTE: this section shows using `derive`, but you can also use one of the builtin palettes.
        See "Generating a Palette" for more information.
]]

local bg = vim.api.nvim_get_option 'background' -- get the background
local palette = Palette.derive(bg, bg == 'dark' and {
  bg = '#202020',
  error = '#aa0000',
  func = '#cc00aa',
  hint = '#cc0055',
  info = '#ccbb88',
  ok = '#33bb55',
  statement = '#33ccFF',
  storage = '#cc7700',
  text = '#cccccc',
  uri = '#00aa00',
  warning = '#ffbb00',
} or {
  -- light palette goes here
})

--- NOTE: this part is optional!
--- @type highlite.color.palette.terminal
local terminal_palette = {
  '#101017', '#aa0000', '#33bb55', '#cc7700', '#133099', '#990066', '#33ccFF', '#cccccc',
  '#808080', '#FF2222', '#00aa00', '#7f6f20', '#1259ff', '#cc00aa', '#3388aa', '#ffffff',
}

--[[ Generate Groups ]]
local groups = Highlite.groups('default', palette)

--[[ Override Groups ]]

-- Get the bracket group, and extend it to add italics
groups.luaStringLongTag = Groups.extend({italic = true}, groups '@punctuation.bracket')

-- Use `msgsep` in `fillchars`? Override `MsgSeparator` to only highlight the foreground
groups.MsgSeparator = {fg = colors.text_contrast_bg_high}

--[[ Setup ]]
Highlite.setup('highlite-example', groups, terminal_palette)
```

## Importing Colorschemes

> **Note**
>
> If you are trying to port a colorscheme as a contribution to `nvim-highlite`, there is an even easier way. See [Porting Colorschemes](./contributing.md#porting-colorschemes).

> **Note**
>
> This feature requires requires Neovim 0.9+.

`nvim-highlite` provides an import module to allow importing colorschemes _from_ various formats _to_ one that it recognizes.

| Data Type        | `&bg` | Field            |
|:-----------------|:------|:-----------------|
| Color Palette    | Dark  | `dark.palette`   |
| Color Palette    | Light | `light.palette`  |
| Terminal Palette | Dark  | `dark.terminal`  |
| Terminal Palette | Light | `light.terminal` |

For example, if you do:

```lua
local Import = require 'highlite.import' --- @type highlite.Import
local imported = Import.nvim 'zellner'
```

Then `imported.dark.palette` is the color palette for a dark `&background`.

> **Warning**
>
> Importing is slow! You should not import another colorscheme _in_ your colorscheme file. For example, this colorscheme will load slowly:
>
> ```lua
> local Import = require 'highlite.import' --- @type highlite.Import
> local Highlite = require 'highlite' --- @type Highlite
>
> local bg = vim.api.nvim_get_option 'background'
> local imported = Import.nvim 'zellner'
>
> Highlite.setup(
>   'example',
>   Highlite.groups('default', imported[bg].palette),
>   imported[bg].terminal
> )
> ```
>
> Instead, you should use something like [`MiniMisc.put_text`](https://github.com/echasnovski/mini.misc) or `vim.inspect` & `nvim_buf_set_text` to insert the import into the colorscheme file directly.

### Vim colorschemes

Supports _any_ colorscheme that can be accessed via `:colorscheme`. Doesn't matter if it was written in Lua, Python, Rust, VimScript, etc.

```lua
local Import = require 'highlite.import' --- @type highlite.Import
local imported = Import.nvim 'zellner'
```

## Tips

### Helpful Tools

#### `mini.colors`

[`echasnovski/mini.colors`](https://github.com/echasnovski/mini.colors) is a fantastic plugin (as is the rest of `mini.nvim`) that allows you to easily manipulate colors, fiddle with existing colorschemes, and generate light/dark variants of a specific palette.

If you have used [rktjmp/lush.nvim](https://github.com/rktjmp/lush.nvim) and miss its suite of utilities to work with colors / preview your work in this plugin, `mini.colors` may be able to help bridge the gap!

[ayu]: https://github.com/ayu-theme/ayu-vim
[creating-your-colorscheme]: #creating-your-colorscheme
[deriving-a-palette]: #deriving-a-palette
[everforest]: https://github.com/sainnhe/everforest
[gruvbox-material]: https://github.com/sainnhe/gruvbox-material
[gruvbox]: https://github.com/morhetz/gruvbox
[iceberg]: https://github.com/cocopon/iceberg.vim
[molokai]: https://github.com/tomasr/molokai
[papercolor]: https://github.com/nlknguyen/papercolor-theme
[seoul256]: https://github.com/junegunn/seoul256.vim
[solarized]: https://github.com/lifepillar/vim-solarized8
[sonokai]: https://github.com/sainnhe/sonokai
