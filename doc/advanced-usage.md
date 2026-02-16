# Advanced Usage

Welcome to the advanced usage guide for `nvim-highlite`! This will teach you how to create your own colorscheme using this plugin, whether it be from scratch, one of our built-in colorschemes, or another existing colorscheme.

## tl;dr

* [Create a Colorscheme](#complete-example)
* [Import a Colorscheme](#importing-colorschemes)

## Creating Your Colorscheme

At last, you are ready to create a colorscheme! You should follow these sections in order to ensure your success.

### Where to Put Your Colorscheme

Colorschemes must be defined in a very specific location in order to be visible to Neovim's `:colorscheme` command. In order for `:colorscheme foo` to work, there must be a `colors/foo.vim` or `colors/foo.lua` file located within your `&runtimepath`.

> **Note**
>
> To check your runtime path, do `:lua for _, p in ipairs(vim.opt.rtp:get()) do print(p) end`.

#### Personal Colorscheme

If you are making this colorscheme for yourself, that file should be in your configuration directory. Run this snippet to show where that is:

```vim
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

There are currently [80+ fields to a palette](#list-of-palette-colors), and that number will probably only grow over time. To make the process of creating a palette for `nvim-highlite` easier, there is `Palette.derive`. Using this function, only 6(!!) colors need to be defined:

```lua
local Palette = require 'highlite.color.palette' --- @type highlite.color.Palette
local colors = Palette.derive('dark', {
  bg = '#202020', -- colors can be a string
  error = 0xAA0000, -- or an integer
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

> **Warning**
>
> While other colors may either be a string (e.g. `'#FFFFFF'`) or an integer (e.g. `0xFFFFFF`), but the colors in the terminal palette _must_ be strings.

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

The `terminal_palette` will automatically be `nil` when you turn off terminal highlighting in `generate`.

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

#### List of Palette Colors

<!--
If you need to regenerate this list, you can run the following command (just make sure to update the line ranges):

```fish
bat -r 6:119 lua/highlite/color/palette/init.lua \
| mlr --nidx --omd --fs space \
	put -q 'emit1 {"Field": "`" . $3 . "`", "Definition": joinv(mapexcept($*, ["1", "2", "3", "4"]), OFS)}' \
	then join \
		--imd \
		--ur \
		-j Field \
		-f (
			bat -r 131:237 lua/highlite/color/palette/init.lua  \
			| mlr --inidx --omd --ifs-regex '[^\\w]+' --ofs space put -q 'emit1 {"Field": "`" . $2 . "`", "Default": "`" . $3 . "`"}' \
			| psub
		) \
	then unsparsify \
	then sort -f Field
```
-->

**Remember:** you do not need to define all of these.

| Field                   | Default                 | Definition                                                                              |
| ---                     | ---                     | ---                                                                                     |
| `annotation`            | `attribute`             |                                                                                         |
| `attribute_builtin`     | `special`               | builtin attributes                                                                      |
| `attribute`             | `preproc`               |                                                                                         |
| `bg_contrast_high`      | `bg`                    | an accent to the `bg` color which contrasts                                             |
| `bg_contrast_low`       | `bg`                    | an accent to the `bg` color which barely contrasts                                      |
| `bg`                    |                         | the background color                                                                    |
| `boolean`               | `constant`              | `true` and `false`                                                                      |
| `buffer_active`         | `text_contrast_bg_high` | the underline of an active buffer                                                       |
| `buffer_alternate`      | `search`                | the underline of the alternate buffer                                                   |
| `buffer_current`        | `select`                | the underline of the current buffer                                                     |
| `character_special`     | `special`               | special characters e.g. wildcards                                                       |
| `character`             | `string`                | character literals (e.g. `'a'`)                                                         |
| `class`                 | `structure`             | data with behavior                                                                      |
| `comment_documentation` | `comment`               | documentation comments                                                                  |
| `comment_special`       |                         | special tokens in a comment                                                             |
| `comment`               | `text_contrast_bg_low`  | normal comments                                                                         |
| `conditional`           | `keyword`               | e.g. `if`, `match`, `switch`                                                            |
| `constant_builtin`      | `special`               | built-in constant values                                                                |
| `constant`              | `storage`               | constant values                                                                         |
| `constructor`           | `type`                  | invoked by `new`                                                                        |
| `decorator`             | `attribute`             |                                                                                         |
| `define`                | `preproc`               | e.g. `#define` in C                                                                     |
| `diff_add`              | `ok`                    | added text                                                                              |
| `diff_change`           | `number`                | changed text, also applies to modified buffers in the tabline                           |
| `diff_delete`           | `error`                 | removed text                                                                            |
| `diff_syntax_add`       | `ok`                    | added text within a (universal) diff                                                    |
| `diff_syntax_change`    | `number`                | changed text within a (universal) diff                                                  |
| `diff_syntax_delete`    | `error`                 | removed text within a (universal) diff                                                  |
| `enum`                  | `structure`             | an enumeration                                                                          |
| `error`                 |                         | diagnostic errors                                                                       |
| `event`                 | `loop`                  | events e.g. `public event FooEventHandler FooEvent` in C#                               |
| `field_enum`            | `constant`              | a variant of an enum e.g. `Ok` in Rust                                                  |
| `field`                 | `property`              | a member of a class/struct which is accessed directly                                   |
| `float`                 | `number`                | floating point numbers                                                                  |
| `fold`                  | `func`                  | the background of `&foldtext`                                                           |
| `func_builtin`          | `special`               | builtin function                                                                        |
| `func`                  | `statement`             | functions, e.g. `print('a')`                                                            |
| `heading_1`             | `error`                 | level 1 heading                                                                         |
| `heading_2`             | `warning`               | level 2 heading                                                                         |
| `heading_3`             | `diff_change`           | level 3 heading                                                                         |
| `heading_4`             | `string`                | level 4 heading                                                                         |
| `heading_5`             | `type`                  | level 5 heading                                                                         |
| `heading_6`             | `fold`                  | level 6 heading                                                                         |
| `hint`                  | `info`                  | diagnostic hints                                                                        |
| `identifier`            | `text`                  | misc. identifier                                                                        |
| `include`               | `preproc`               | e.g. `#include` in C                                                                    |
| `info`                  | `warning`               | diagnostic info                                                                         |
| `interface_builtin`     | `type_builtin`          | e.g. `interface Foo`                                                                    |
| `interface`             | `type`                  | e.g. `interface Foo`                                                                    |
| `keyword_coroutine`     | `keyword`               | e.g. `await`                                                                            |
| `keyword_function`      | `type_builtin`          | e.g. `fn` in Rust, `def` in Python                                                      |
| `keyword_modifier`      | `keyword`               | modifiers for items, e.g. `public`                                                      |
| `keyword_operator`      | `operator`              | e.g. `and` in Lua                                                                       |
| `keyword_return`        | `keyword`               | e.g. `return`, `yield`                                                                  |
| `keyword_type`          | `keyword`               | e.g. "struct"                                                                           |
| `keyword`               | `statement`             | keywords, e.g. `local` in Lua                                                           |
| `label`                 | `special`               | switch cases, loop labels (e.g. `'outer for x in y { break 'outer }` in Rust)           |
| `loop`                  | `conditional`           | e.g. `loop`, `for`, `while`                                                             |
| `macro`                 | `define`                | e.g. `println!` in Rust                                                                 |
| `markup_link_label`     | `string_special`        | markup link/reference descriptions                                                      |
| `markup_list_checked`   | `string_special`        | markup todo-style markers (checked)                                                     |
| `markup_list_unchecked` | `string_special`        | markup todo-style markers (unchecked)                                                   |
| `markup_list`           | `string_special`        | markup list markers                                                                     |
| `markup_quote`          | `comment`               |                                                                                         |
| `message`               | `info`                  | Builtin Vim messages                                                                    |
| `method`                | `func`                  | function of a class                                                                     |
| `namespace_builtin`     | `namespace`             | namespace, but builtin                                                                  |
| `namespace`             | `uri`                   | e.g. `foo::bar` in Rust/C++                                                             |
| `number`                | `constant`              | number literals (e.g `9`)                                                               |
| `ok`                    |                         | positive reinforcement from LSP or Git                                                  |
| `operator`              | `keyword`               | e.g. `+`, `-`, `&&`                                                                     |
| `parameter_builtin`     | `special`               | a builtin function parameter                                                            |
| `parameter`             | `identifier`            | a function parameter                                                                    |
| `preproc_conditional`   | `preproc`               | pre-processor conditionals (e.g. `#[cfg]` in Rust)                                      |
| `preproc`               | `func`                  | pre-processor commands (e.g. `#[derive]` in Rust)                                       |
| `property`              | `identifier`            | a member of a class or structure which is transparently a function                      |
| `punctuation_bracket`   | `punctuation`           | balanced punctuation, e.g. `[]`, `""`, `()`                                             |
| `punctuation_delimiter` | `punctuation`           | single punctuation, e.g. `,`, `;`                                                       |
| `punctuation_special`   | `string_special`        | special punctuation, e.g. `{}` in a format string                                       |
| `punctuation`           | `text_contrast_bg_high` | misc. delimiters                                                                        |
| `search`                | `select`                | Doing `:/` or `:s/`                                                                     |
| `select`                | `bg_contrast_low`       | selected text, e.g. in visual mode or selecting LSP completions                         |
| `special`               | `statement`             | unclassified special symbols in a language                                              |
| `statement`             |                         | programming language statements which do not fall into another category                 |
| `storage`               |                         | pointer symbols (e.g. `&foo`)                                                           |
| `string_documentation`  | `comment_documentation` | strings documenting code                                                                |
| `string_escape`         | `character`             | escaped characters in a string                                                          |
| `string_regex`          | `string`                | regular expressions                                                                     |
| `string_special_symbol` | `string_special`        | symbols or atoms                                                                        |
| `string_special`        | `identifier`            | special strings (e.g. dates)                                                            |
| `string`                | `constant`              | a misc. string                                                                          |
| `structure`             | `type`                  | plain-old data                                                                          |
| `syntax_error`          | `error`                 | non-diagnostic errors; sometimes shown in the actual highlighting of the code you write |
| `tag_attribute`         | `field`                 | XML/HTML tag attributes                                                                 |
| `tag_delimiter`         | `punctuation_bracket`   | `<`/`>` in XML/HTML tags                                                                |
| `tag`                   | `structure`             | XML/HTML tags                                                                           |
| `text_contrast_bg_high` | `text`                  | an accent to the `text` color which contrasts                                           |
| `text_contrast_bg_low`  | `text`                  | an accent to the `text` color which barely contrasts                                    |
| `text_environment_name` | `label`                 | text environment name                                                                   |
| `text_environment`      | `text_contrast_bg_low`  | text environment delimiter                                                              |
| `text_literal`          | `statement`             | literal text                                                                            |
| `text_math`             | `number`                | mathematical text                                                                       |
| `text_reference`        | `uri`                   | references to variables in text                                                         |
| `text`                  |                         | plaintext                                                                               |
| `throw`                 | `error`                 | a keyword which triggers or receives errors (e.g. `throw MyError`)                      |
| `todo`                  | `message`               | `TODO` comments                                                                         |
| `type_builtin`          | `type`                  | a type from the standard library                                                        |
| `type_definition`       | `type`                  | typedefs                                                                                |
| `type_parameter`        | `type`                  | generic type                                                                            |
| `type`                  | `keyword`               | type names e.g. `int`, `String`                                                         |
| `uri`                   | `text`                  | links (HTTP, tags, match paren, etc).                                                   |
| `variable_builtin`      | `keyword`               | a variable from the language, e.g. `self`                                               |
| `variable`              | `identifier`            | a variable                                                                              |
| `warning`               | `error`                 | diagnostic warnings                                                                     |


##### Extending the Palette

You may add *extra* colors to the palette, if what is available is not fine-grained enough. You can add as many colors as you like. Example:

```lua
local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'highlite'

-- also works with derive
palette.my_custom_color = '#FF0000'

local groups = Highlite.groups('default', palette)
groups.Error = {fg = palette.my_custom_color}

-- … other colorscheme logic
```

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

| Name             | Description                                                    | Parent Group |
|:-----------------|:---------------------------------------------------------------|:-------------|
| `default`        | The default groups: all Neovim built-ins and some Lua plugins. |              |
| `highlite`       | Overrides for the `highlite` pallete.                          | `default`    |
| `seoul256-light` | Overrides for the `seoul256-light` pallete.                    | `seoul256`   |
| `seoul256`       | Overrides for the `seoul256` pallete.                          | `default`    |

#### 2a. Overriding Groups (Optional)

`nvim-highlite` **groups** follow the format of `nvim_set_hl`'s `{val}` parameter. Example:

```lua
local colors = require('highlite.color.palette').derive(…) -- see "Deriving a Palette" for more info
local normal = {fg = colors.text, bg = colors.bg}
```

`nvim-highlite` also accepts a shorthand `:highlight link` syntax:

```lua
local float = 'Number' -- same as `{link = 'Number'}`
```

##### Resolving Highlight Links

`nvim-highlite` provides a convenient way to resolve highlight links within the defined colorscheme:

```lua
--- @param group string
--- @return nil|table
```

Example:

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

-- you can chain resolves, in case one group isn't available
groups.Zyx = {fg = (groups"Doesn't Exist" or groups'Might Exist' or {}).fg}
```

###### Limitations

* For LSP and treesitter groups: if `@foo.bar` is not defined explicitly, the un-linker will not attempt to lookup `@foo`.
  * As a workaround, you can do `groups'@foo.bar' or groups'@foo' or {}` to check for the existence of fallback highlights manually.

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
> There is a way to resolve highlight links into a valid group definition— see [Resolving Highlight Links](#resolving-highlight-links).

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


### 3. Generate

Finally, now that you have your **palette** and your **groups**, you can generate your colorscheme:

```lua
require('highlite').generate(
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

--[[ Generate ]]
Highlite.generate('highlite-example', groups, terminal_palette)
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
> Highlite.generate(
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

#### `:Inspect` / `:InspectTree`

Neovim 0.9+ comes with the built-in `:Inspect` & `:InspectTree` commands. They let you analyze the highlights that are being applied to the character under your cursor.

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
