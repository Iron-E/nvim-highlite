-- This file should be edited by the user. Read the instructions of each section and then edit them as desired.

--[[ Highlite, a Neovim colorscheme template.
* Author:     Iron-E (https://github.com/Iron-E)
* Repository: https://github.com/nvim-highlite

Initially forked from vim-rnb, a Vim colorsheme template:
* Author:        Romain Lafourcade (https://github.com/romainl)
* Canonical URL: https://github.com/romainl/vim-rnb
]]

--[[ Introduction
This template is designed to help Neovim users create their own colorschemes
without much effort. You will not need any additional tooling: just open it
in Neovim and follow the instructions.

The process is divided in five steps:

1. Rename the template,
2. Edit your colorscheme's information,
3. Define your colors,
4. Define your highlight groups and links, and
5. Sourcing your colorscheme.
]]

--[[ Step 1: Renaming
* If this file is distributed with a colorscheme it's probably already named correctly
  and you can skip this step.
* If you forked/cloned/copied this repository to create your own colorscheme, you will have to
  rename this template to match the name of your colorscheme.

NOTE: Neovim doesn't really care about whitespace in the name of the colorscheme but it does for
filenames so make sure your filename doesn't have any whitespace character.

| colorscheme name  | module name | template filename |
|:-----------------:|:-----------:|:-----------------:|
| foobar            | foobar      | foobar.lua        |
| foo-bar           | foo_bar     | foo_bar.lua       |
| foo bar           | foo_bar     | foo_bar.lua       |
| foo_bar           | foo_bar     | foo_bar.lua       |

Rename the following files:

* `colors/highlite.lua` → `colors/<your_colorscheme>.lua`
* `lua/highlite.lua` → `lua/<your_colorscheme>.lua`
* `lua/highlite/colors.lua` → `lua/<your_colorscheme>/colors.lua`

NOTE: If you are on a Unix-based system (or have WSL on Windows) you can use the setup script at the root of this repo.
	   See the README for more details.
]]


--[[ Step 2: Information
In this step you will define information that helps Neovim process:

1. How users access your colorscheme;
2. How your colorscheme should be rendered.
]]

-- This is the name of your colorscheme which will be used as per |g:colors_name|.
local colorscheme_name = 'highlite'

-- WARN: users shouldn't touch this.
vim.api.nvim_set_var('colors_name', colorscheme_name)

--[[ Step 3: Colors
Here you define all of the colors that you will use for the color scheme. Each one is made up of three parts:

```lua
<color name> = { -- Give each color a distinctive name.
	'#<hex color code>', -- Hexadecimal color used in GVim/MacVim
	<8-bit color code>, -- Integer 0–255 used by terminals supporting 256 colors
	'<ANSI color name>'  -- color name used by less capable color terminals, can be 'darkred',
								  'red', 'darkgreen', 'green', 'darkyellow', 'yellow', 'darkblue',
								  'blue', 'darkmagenta', 'magenta', 'black', 'darkgrey', 'grey',
								  'white'
}
```

NOTE: See https://gist.github.com/gagbo/7943c9a71cab22b641d2904a6d59ec3a
		for a program that can generate 16-bit colors from a Hex code.

If your colors are defined correctly, the resulting colorscheme is guaranteed
to work in GVim (Windows/Linux), MacVim (MacOS), and any properly set up terminal
emulator. Type errors in the definition will show up as LSP diagnostics.

NOTE: |Replace-mode| will probably be useful here.
]]

local black       = {'#202020', 235, 'black'} --- @type highlite.color.definition
local gray        = {'#808080', 244, 'gray'} --- @type highlite.color.definition
local gray_dark   = {'#353535', 236, 'darkgrey'} --- @type highlite.color.definition
local gray_darker = {'#505050', 239, 'gray'} --- @type highlite.color.definition
local gray_light  = {'#c0c0c0', 250, 'gray'} --- @type highlite.color.definition
local white       = {'#ffffff', 231, 'white'} --- @type highlite.color.definition

local tan = {'#f4c069', 221, 'yellow'} --- @type highlite.color.definition

local red       = {'#ee4a59', 203, 'red'} --- @type highlite.color.definition
local red_dark  = {'#a80000', 124, 'darkred'} --- @type highlite.color.definition
local red_light = {'#ff4090', 205, 'red'} --- @type highlite.color.definition

local orange       = {'#ff8900', 208, 'darkyellow'} --- @type highlite.color.definition
local orange_light = {'#f0af00', 214, 'darkyellow'} --- @type highlite.color.definition

local yellow = {'#f0df33', 227, 'yellow'} --- @type highlite.color.definition

local green_dark  = {'#70d533', 113, 'darkgreen'} --- @type highlite.color.definition
local green       = {'#22ff22', 46,  'green'} --- @type highlite.color.definition
local green_light = {'#99ff99', 120, 'green'} --- @type highlite.color.definition
local turqoise    = {'#2bff99', 48,  'green'} --- @type highlite.color.definition

local blue = {'#7766ff', 63,  'darkblue'} --- @type highlite.color.definition
local cyan = {'#33dbc3', 80,  'cyan'} --- @type highlite.color.definition
local ice  = {'#95c5ff', 111, 'cyan'} --- @type highlite.color.definition
local teal = {'#60afff', 75,  'blue'} --- @type highlite.color.definition

local magenta      = {'#d5508f', 168, 'magenta'} --- @type highlite.color.definition
local magenta_dark = {'#bb0099', 126, 'darkmagenta'} --- @type highlite.color.definition
local pink         = {'#ffa6ff', 219, 'magenta'} --- @type highlite.color.definition
local pink_light   = {'#ffb7b7', 217, 'white'} --- @type highlite.color.definition
local purple       = {'#cf55f0', 171, 'magenta'} --- @type highlite.color.definition
local purple_light = {'#af60af', 133, 'darkmagenta'} --- @type highlite.color.definition

--[[ Step 4: highlights
You can define highlight groups like this:

```lua
<highlight group name> = {
	-- The color for the background, or `nil`
	bg = <color>,

	-- The color for the foreground, or `nil`
	fg = <color>

	-- The |guisp| value, if one is desired.
	[, sp = <color>]

	-- The |highlight-blend| value, if one is desired.
	[, blend = <integer>]

	-- Bold, italic, and more. See |attr-list| for more information.
	[, bold = true|false]
	[, default = true|false]
	[, italic = true|false]
	[, nocombine = true|false]
	[, reverse = true|false]
	[, standout = true|false]
	[, strikethrough = true|false]
	[, undercurl = true|false]
	[, underdashed = true|false]
	[, underdotted = true|false]
	[, underdouble = true|false]
	[, underline = true|false]
}
```

You can also link one highlight group to another:

```lua
<highlight group name> = '<highlight group name>'
```
____________________________________________________________________________

Here is an example to define `SpellBad` and then link some new group
`SpellWorse` to it:

```lua
SpellBad = { -- ← name of the highlight group
	bg = nil, -- no background
	fg = white, -- white foreground
	sp = red, -- red underline
	undercurl = true, -- squiggly line
},

SpellWorse = 'SpellBad' -- link SpellWorse to SpellBad
```

If you weren't satisfied with undercurl, and also wanted another effect, you can
add another one below 'undercurl' and it will be applied as well:

```lua
SpellBad = { -- ← name of the highlight group
	bg = nil, -- no background
	fg = white, -- white foreground
	sp = red, -- red underline
	standout = true,
	undercurl = true, -- squiggly line
},
```
____________________________________________________________________________

If you want to create a colorscheme that is responsive to the user's
'background' setting, you can specify special `light` and `dark` keys to
define how each group should be highlighted in each case.

```lua
SpellBad = {
	bg = nil,
	dark = {fg = white},
	light = {fg = black},
	sp = red,
	undercurl = true,
}
```

Whenever the user changes their 'background' setting, the settings inside of
whichever key is relevant will be loaded.
____________________________________________________________________________

You can add any custom highlight group to the standard list below but you
shouldn't remove any if you want a working colorscheme. Most of them are
described under |highlight-default|, some from |group-name|, and others from
common syntax groups.  Both help sections are good reads.
____________________________________________________________________________

If you want to inherit a specific attribute of another highlight group, you
can do the following:

```lua
-- copy `SpellRare` except `sp = red`
SpellBad = function(self)
	local definition = vim.deepcopy(self.SpellRare)
	definition.sp = red
	return definition
end
```

The function will be executed by |highlite| and transformed into the
expected result.
____________________________________________________________________________

NOTE: |Replace-mode| will probably be useful here.

NOTE: /As long as you do not remove any highlight groups or colors/, you can
		safely ignore any highlight groups that are `link`ed to others.

		For example, programming languages almost exclusively link to the 1st
		and 2nd sections, so as long as you define everything there you will
		automatically be defining the rest of the highlights, which is one of
		the benefits of using this template.
]]

-- WARN: users shouldn't touch this.
local colorscheme = require(colorscheme_name)

--[[ These are the ones you should edit.
     TIP: you can use `colors.black`, etc to access what you defined in the other file. ]]
colorscheme.highlight_all {
	--[[ Plaintext ]]

	-- Basic styles
	Bold = {bold = true},
	Italic = {italic = true},
	Normal = {fg = gray_light},
	Title = {link = 'Bold'},
	Underlined = {fg = turqoise, underline = true},
	Whitespace = {link = 'NonText'},

	-- "Non"-text
	Conceal = {link = 'NonText'},
	EndOfBuffer = {link = 'NonText'},
	Ignore = {fg = gray},
	NonText = {fg = gray_darker},

	-- Literals
	Constant = {fg = orange_light},
	String = {fg = green_dark},
	Character = {fg = red_light},
	Number = {fg = pink_light},
	Boolean = {fg = yellow},
	Float = {link = 'Number'},

	-- Syntax
	Comment = {fg = gray, italic = true},
	Conditional = {fg = ice, italic = true},
	Debug = {link = 'WarningMsg'},
	Delimiter = {fg = white},
	Exception = {fg = red_light, bold = true},
	Function = {fg = purple},
	Identifier = function(self) return {fg = self.Normal.fg} end,
	Keyword = {fg = teal},
	Label = {fg = pink, bold = true},
	Noise = {link = 'Delimiter'},
	Operator = {fg = green, bold = true},
	Repeat = {fg = turqoise, italic = true},
	Statement = {fg = ice},
	StorageClass = {fg = orange_light, bold = true},
	Structure = {fg = blue, bold = true},
	Tag = {link = 'Underlined'},
	Type = {fg = cyan},
	Typedef = {fg = cyan, italic = true},

	-- Pre-processor
	Define = {fg = blue, nocombine = true},
	Include = {fg = green_light, nocombine = true},
	Macro = {fg = blue, italic = true},
	PreCondit = {fg = tan, italic = true},
	PreProc = {fg = tan},

	-- Special
	Special = {fg = magenta, bold = true},
	SpecialChar = {fg = red_light, italic = true},
	SpecialComment = {fg = gray, bold = true, nocombine = true},
	SpecialKey = {link = 'Character'},

	-- LSP
	['@lsp.mod.constant'] = {link = '@constant'},
	['@lsp.mod.readonly'] = {link = '@lsp.mod.constant'},
	['@lsp.type.boolean'] = {link = '@boolean'},
	['@lsp.type.character'] = {link = '@character'},
	['@lsp.type.float'] = {link = '@float'},
	['@lsp.type.interface'] = {link = '@lsp.type.type'},
	['@lsp.type.namespace'] = {link = '@namespace'},
	['@lsp.type.number'] = {link = '@number'},
	['@lsp.type.operator'] = {link = '@operator'},
	['@lsp.type.string'] = {link = '@string'},

	-- treesitter
	['@constant.builtin'] = {link = '@constant'},
	['@constant.macro'] = {link = '@define'},
	['@constructor'] = {link = '@function'},
	['@function.builtin'] = {link = '@function'},
	['@function.macro'] = {link = '@macro'},
	['@namespace'] = {link = 'Directory'},
	['@string.escape'] = {link = '@string.special'},
	['@tag'] = {link = 'Tag'},
	['@text.danger'] = {link = 'ErrorMsg'},
	['@text.literal'] = {link = 'mkdCode'},
	['@text.uri'] = {link = 'Underlined'},
	['@text.warning'] = {link = 'WarningMsg'},

	--[[ Editor UI ]]

	-- Status Line
	StatusLine = {fg = green_light, bg = gray_darker},
	StatusLineNC = function(self) return {fg = gray, bg = self.StatusLine.bg} end,
	StatusLineTerm = {link = 'StatusLine'},
	StatusLineTermNC = {link = 'StatusLineNC'},

	-- Tabline
	TabLine = function(self) return {fg = self.Normal.fg, bg = self.StatusLine.bg} end,
	TabLineFill = function(self) return {fg = self.TabLine.bg, bg = black} end,
	TabLineSel = function(self) return {fg = self.TabLine.fg, bg = self.Normal.bg} end,

	-- Line Highlighting
	CursorLine = {bg = gray_dark},
	CursorLineNr = function(self) return {fg = pink, bg = self.LineNr.bg} end,
	LineNr = {fg = gray},
	QuickFixLine = function(self) return {bg = self.StatusLine.bg} end,
	Visual = {reverse = true},
	VisualNOS = {bg = gray_darker},

	-- Popups
	FloatBorder = {fg = gray},
	Pmenu = function(self) return {fg = self.Normal.fg, bg = gray_dark} end,
	PmenuSbar = {bg = gray_darker},
	PmenuSel = {fg = black, bg = gray_light},
	PmenuThumb = {bg = white},
	WildMenu = {link = 'PmenuSel'},

	-- Folds
	FoldColumn = {bg = gray_darker, bold = true},
	Folded = {fg = black, bg = purple_light, italic = true},

	-- Diffs
	DiffAdd = {fg = black, bg = green_dark},
	diffAdded = {link = 'DiffAdd'},
	DiffChange = {},
	DiffDelete = function(self) return {fg = self.DiffAdd.fg, bg = red} end,
	DiffText = function(self) return {fg = self.DiffAdd.fg, bg = yellow} end,
	diffRemoved = {link = 'DiffDelete'},

	-- Searching
	IncSearch = {reverse = true},
	MatchParen = {fg = green, bold = true, underline = true},
	Search = {sp = white, underline = true},

	-- Spelling
	SpellBad = {sp = red, undercurl = true},
	SpellCap = {sp = yellow, undercurl = true},
	SpellLocal = {sp = green, undercurl = true},
	SpellRare = {sp = orange, undercurl = true},

	-- Conditional Column Highlighting
	ColorColumn = {reverse = true},
	SignColumn = {},

	-- Messages
	Error = {fg = white, bg = red_dark, bold = true},
	ErrorMsg = {fg = red, bold = true},
	ModeMsg = {fg = yellow},
	Question = {fg = orange_light, underline = true},
	Todo = {fg = black, bg = cyan, bold = true},
	WarningMsg = {fg = orange, bold = true},

	-- Diagnostics
	debugBreakpoint = {link = 'ErrorMsg'},
	debugPC = {link = 'ColorColumn'},

	DiagnosticError = {link = 'Error'},
	DiagnosticFloatingError = {link = 'ErrorMsg'},
	DiagnosticSignError = {link = 'DiagnosticFloatingError'},

	DiagnosticWarn = {fg = black, bg = orange, bold = true},
	DiagnosticFloatingWarn = {link = 'WarningMsg'},
	DiagnosticSignWarn = {link = 'DiagnosticFloatingWarn'},

	DiagnosticHint = {fg = black, bg = magenta, bold = true},
	DiagnosticFloatingHint = {fg = magenta, italic = true},
	DiagnosticSignHint = {link = 'DiagnosticFloatingHint'},

	DiagnosticInfo = {fg = black, bg = pink_light, bold = true},
	DiagnosticFloatingInfo = {fg = pink_light, italic = true},
	DiagnosticSignInfo = {link = 'DiagnosticFloatingInfo'},

	DiagnosticUnderlineError = {sp = red, undercurl = true},
	DiagnosticUnderlineHint = {sp = magenta, undercurl = true},
	DiagnosticUnderlineInfo = {sp = pink_light, undercurl = true},
	DiagnosticUnderlineWarn = {sp = orange, undercurl = true},

	-- Cursor
	Cursor = {reverse = true},
	CursorIM = {link = 'Cursor'},
	CursorColumn = {bg = gray_dark},

	-- Misc
	Directory = {fg = ice, bold = true},
	VertSplit = {fg = white},

	--[[ Programming Languages
		Everything in this section is OPTIONAL. Feel free to remove everything
		here if you don't want to define it, or add more if there's something
		missing. ]]

	-- Coq
	coqConstructor = {link = 'Constant'},
	coqDefBinderType = {link = 'coqDefType'},
	coqDefContents1 = {link = 'coqConstructor'},
	coqDefType = {link = 'Typedef'},
	coqIndBinderTerm = {link = 'coqDefBinderType'},
	coqIndConstructor = {link = 'Delimiter'},
	coqIndTerm = {link = 'Type'},
	coqKwd = {link = 'Keyword'},
	coqKwdParen = {link = 'Function'},
	coqProofDelim = {link = 'coqVernacCmd'},
	coqProofDot = {link = 'coqTermPunctuation'},
	coqProofPunctuation = {link = 'coqTermPunctuation'},
	coqRequire = {link = 'Include'},
	coqTactic = {link = 'Operator'},
	coqTermPunctuation = {link = 'Delimiter'},
	coqVernacCmd = {link = 'Statement'},
	coqVernacPunctuation = {link = 'coqTermPunctuation'},

	-- C++
	cppSTLexception = {link = 'Exception'},
	cppSTLnamespace = {link = 'Directory'},

	-- Crontab
	crontabDay = {link = 'StorageClass'},
	crontabDow = {link = 'String'},
	crontabHr = {link = 'Number'},
	crontabMin = {link = 'Float'},
	crontabMnth = {link = 'Structure'},

	-- C#
	csBraces = {link = 'Delimiter'},
	csClass = {link = 'Structure'},
	csClassType = {link = 'Type'},
	csContextualStatement = {link = 'Conditional'},
	csEndColon = {link = 'Delimiter'},
	csGeneric = {link = 'Typedef'},
	csInterpolation = {link = 'Include'},
	csInterpolationDelimiter = {link = 'SpecialChar'},
	csLogicSymbols = {link = 'Operator'},
	csModifier = {link = 'Keyword'},
	csNew = {link = 'Operator'},
	csNewType = {link = 'Type'},
	csParens = {link = 'Delimiter'},
	csPreCondit = {link = 'PreProc'},
	csQuote = {link = 'Delimiter'},
	csRepeat = {link = 'Repeat'},
	csStorage = {link = 'StorageClass'},
	csUnspecifiedStatement = {link = 'Statement'},
	csXmlTag = {link = 'Define'},
	csXmlTagName = {link = 'Define'},

	-- CSS/SCSS
	cssAtRule = {link = 'PreCondit'},
	cssAttr = {link = 'Keyword'},
	cssAttrComma = {link = 'Noise'},
	cssAttrRegion = {link = 'Keyword'},
	cssBraces = {link = 'Delimiter'},
	cssClassName = {link = 'Identifier'},
	cssClassNameDot = {link = 'Noise'},
	cssFlexibleBoxAttr = {link = 'cssAttr'},
	cssFunctionComma = {link = 'Noise'},
	cssImportant = {link = 'Exception'},
	cssNoise = {link = 'Noise'},
	cssProp = {link = 'Label'},
	cssPseudoClass = {link = 'Special'},
	cssPseudoClassId = {link = 'cssSelectorOp'},
	cssSelectorOp = {link = 'Operator'},
	cssTagName = {link = 'Structure'},
	cssUnitDecorators = {link = 'Type'},

	-- dart
	dartLibrary = {link = 'Statement'},

	-- dos INI
	dosiniHeader = {link = 'Title'},
	dosiniLabel = {link = 'Label'},

	-- dot
	dotKeyChar = {link = 'Character'},
	dotType = {link = 'Type'},

	-- Git
	gitcommitHeader = {link = 'SpecialComment'},
	gitcommitDiscardedFile = {link = 'gitcommitSelectedFile'},
	gitcommitOverFlow = {link = 'Error'},
	gitcommitSelectedFile = {link = 'Directory'},
	gitcommitSummary = {link = 'Title'},
	gitcommitUntrackedFile = {link = 'gitcommitSelectedFile'},
	gitconfigAssignment = {link = 'String'},
	gitconfigEscape = {link = 'SpecialChar'},
	gitconfigNone = {link = 'Operator'},
	gitconfigSection = {link = 'Structure'},
	gitconfigVariable = {link = 'Label'},
	gitrebaseBreak = {link = 'Keyword'},
	gitrebaseCommit = {link = 'Tag'},
	gitrebaseDrop = {link = 'Exception'},
	gitrebaseEdit = {link = 'Define'},
	gitrebaseExec = {link = 'PreProc'},
	gitrebaseFixup = {link = 'gitrebaseSquash'},
	gitrebaseMerge = {link = 'PreProc'},
	gitrebasePick = {link = 'Include'},
	gitrebaseReset = {link = 'gitrebaseLabel'},
	gitrebaseReword = {link = 'gitrebasePick'},
	gitrebaseSquash = {link = 'Macro'},
	gitrebaseSummary = {link = 'Title'},

	-- Go
	goBlock = {link = 'Delimiter'},
	goBoolean = {link = 'Boolean'},
	goBuiltins = {link = 'Function'},
	goField = {link = 'Identifier'},
	goFloat = {link = 'Float'},
	goFormatSpecifier = {link = 'Character'},
	goFunction = {link = 'Function'},
	goFunctionCall = {link = 'goFunction'},
	goFunctionReturn = {},
	goImport = {link = 'Include'},
	goMethodCall = {link = 'goFunctionCall'},
	goPackage = {link = 'goStatement'},
	goParamType = {link = 'goReceiverType'},
	goPointerOperator = {link = 'StorageClass'},
	goPredefinedIdentifiers = {link = 'Constant'},
	goReceiver = {link = 'goBlock'},
	goReceiverType = {link = 'goTypeName'},
	goSimpleParams = {link = 'goBlock'},
	goStatement = {link = 'Keyword'},
	goType = {link = 'Type'},
	goTypeConstructor = {link = 'goFunction'},
	goTypeName = {link = 'Type'},
	goVarAssign = {link = 'Identifier'},
	goVarDefs = {link = 'goVarAssign'},

	-- Help
	helpCommand = {link = 'Statement'},
	helpHeader = {link = 'Label'},
	helpHeadline = {link = 'Title'},
	helpHyperTextJump = {link = 'Tag'},
	helpHyperTextEntry = {link = 'Tag'},
	helpExample = {link = 'Statement'},
	helpNote = {link = 'DiagnosticHint'},
	helpOption = {link = 'Keyword'},
	helpSectionDelim = {link = 'Delimiter'},

	-- HTML
	htmlArg = {link = 'Label'},
	htmlBold = {link = 'Bold'},
	htmlTitle = {link = 'htmlBold'},
	htmlEndTag = {link = 'htmlTag'},
	htmlH1 = {link = 'markdownH1'},
	htmlH2 = {link = 'markdownH2'},
	htmlH3 = {link = 'markdownH3'},
	htmlH4 = {link = 'markdownH4'},
	htmlH5 = {link = 'markdownH5'},
	htmlH6 = {link = 'markdownH6'},
	htmlItalic = {link = 'Italic'},
	htmlSpecialTagName = {link = 'Keyword'},
	htmlTag = {link = 'Special'},
	htmlTagN = {link = 'Typedef'},
	htmlTagName = {link = 'Type'},

	-- i3config
	i3ConfigAction = {link = 'Function'},
	i3ConfigAssignKeyword = {link = 'Keyword'},
	i3ConfigAssign = {link = 'i3ConfigVariable'},
	i3ConfigBind = {link = '@text'},
	i3ConfigBindKeyword = {link = 'Keyword'},
	i3ConfigBlockKeyword = {link = 'Keyword'},
	i3ConfigBorderKeyword = {link = 'Keyword'},
	i3ConfigBorderStyleKeyword = {link = 'Keyword'},
	i3ConfigClientColorKeyword = {link = 'Keyword'},
	i3ConfigCommandKeyword = {link = 'Keyword'},
	i3ConfigDelayUrgencyKeyword = {link = 'Keyword'},
	i3ConfigDrawingMarksKeyword = {link = 'Keyword'},
	i3ConfigEdgeKeyword = {link = 'Keyword'},
	i3ConfigExec = {link = 'Statement'},
	i3ConfigExecKeyword = {link = 'Keyword'},
	i3ConfigFloating = {link = 'Keyword'},
	i3ConfigFocusFollowsMouseKeyword = {link = 'Keyword'},
	i3ConfigFocusOnActivationKeyword = {link = 'Keyword'},
	i3ConfigFocusWrappingKeyword = {link = 'Keyword'},
	i3ConfigFontContent = {link = 'String'},
	i3ConfigFontKeyword = {link = 'Keyword'},
	i3ConfigFontSeparator = {link = 'Delimiter'},
	i3ConfigFontSize = {link = 'i3ConfigNumber'},
	i3ConfigForceXineramaKeyword = {link = 'Keyword'},
	i3ConfigGapStyleKeyword = {link = 'Keyword'},
	i3ConfigInitialize = {link = 'String'},
	i3ConfigInitializeKeyword = {link = 'Keyword'},
	i3ConfigInterprocessKeyword = {link = 'Keyword'},
	i3ConfigLayoutKeyword = {link = 'Keyword'},
	i3ConfigMouseWarpingKeyword = {link = 'Keyword'},
	i3ConfigNoFocusKeyword = {link = 'Keyword'},
	i3ConfigNoStartupId = {link = 'i3ConfigBindArgument'},
	i3ConfigNumber = {link = 'Number'},
	i3ConfigOrientationKeyword = {link = 'Keyword'},
	i3ConfigPopupOnFullscreenKeyword = {link = 'Keyword'},
	i3ConfigResourceKeyword = {link = 'Keyword'},
	i3ConfigSmartBorderKeyword = {link = 'Keyword'},
	i3ConfigSmartGapKeyword = {link = 'Keyword'},
	i3ConfigString = {link = 'String'},
	i3ConfigTitleAlignKeyword = {link = 'Keyword'},
	i3ConfigVariable = {link = 'Define'},
	i3ConfigVariableAndModifier = {link = 'Character'},
	i3ConfigVariableModifier = {link = 'Operator'},
	i3ConfigWindowCommandSpecial = {link = 'htmlTag'},
	i3ConfigWorkspaceKeyword = {link = 'Keyword'},

	-- Java
	javaClassDecl = {link = 'Structure'},

	-- JavaScript
	jsFuncBlock = {link = 'Function'},
	jsObjectKey = {link = 'Type'},
	jsReturn = {link = 'Keyword'},
	jsVariableDef = {link = 'Identifier'},

	-- JSON
	jsonBraces = {link = 'luaBraces'},
	jsonEscape = {link = 'SpecialChar'},
	jsonKeywordMatch = {link = 'Operator'},
	jsonNull = {link = 'Constant'},
	jsonQuote = {link = 'Delimiter'},
	jsonString = {link = 'String'},
	jsonStringSQError = {link = 'Exception'},

	-- Lua
	['@lsp.type.function.lua'] = {},
	['@lsp.type.keyword.lua'] = {link = 'SpecialComment'},
	['@lsp.typemod.function.declaration.lua'] = {link = '@lsp.type.function'},
	['@lsp.typemod.variable.defaultLibrary.lua'] = {link = '@lsp.type.class.lua'},
	['@lsp.typemod.variable.definition.lua'] = {link = '@punctuation'},
	luaBraces = {link = 'Structure'},
	luaBrackets = {link = 'Delimiter'},
	luaBuiltin = {link = 'Keyword'},
	luaComma = {link = 'Delimiter'},
	luaDocTag = {link = 'SpecialComment'},
	luaFuncArgName = {link = 'Identifier'},
	luaFuncCall = {link = 'Function'},
	luaFuncId = {link = 'luaNoise'},
	luaFuncKeyword = {link = 'Type'},
	luaFuncName = {link = 'Function'},
	luaFuncParens = {link = 'Delimiter'},
	luaFuncTable = {link = 'Structure'},
	luaFunction = {link = 'Keyword'},
	luaGotoLabel = {link = 'luaLabel'},
	luaIn = {link = 'luaRepeat'},
	luaLocal = {link = 'Keyword'},
	luaNoise = {link = 'Delimiter'},
	luaParens = {link = 'Delimiter'},
	luaSpecialTable = {link = 'Structure'},
	luaSpecialValue = {link = 'Function'},
	luaStatement = {link = 'Keyword'},
	luaStringLongTag = function(self)
		local delimiter = self.Delimiter
		return {bg = delimiter.bg, fg = delimiter.fg, italic = true}
	end,

	-- Make
	makeCommands = {link = 'Statment'},
	makeSpecTarget = {link = 'Type'},

	-- Man
	manHeader = {link = 'markdownH1'},
	manOptionDesc = {link = 'Special'},
	manReference = {link = '@text.uri'},
	manSectionHeading = {link = 'markdownH2'},
	manSubHeading = {link = 'markdownH3'},
	manUnderline = {link = '@text.literal'},

	-- Markdown
	markdownCode = {link = 'mkdCode'},
	markdownCodeDelimiter = {link = 'mkdCodeDelimiter'},
	markdownH1 = {fg = red, bold = true},
	markdownH2 = {fg = orange, bold = true},
	markdownH3 = {fg = yellow, bold = true},
	markdownH4 = {fg = green_dark, bold = true},
	markdownH5 = {fg = cyan, bold = true},
	markdownH6 = {fg = purple_light, bold = true},
	markdownLinkDelimiter = {link = 'mkdDelimiter'},
	markdownLinkText = {link = 'mkdLink'},
	markdownLinkTextDelimiter = {link = 'markdownLinkDelimiter'},
	markdownUrl = {link = 'mkdURL'},
	mkdBold = {link = 'Ignore'},
	mkdBoldItalic = {link = 'mkdBold'},
	mkdCode = {link = 'Statement'},
	mkdCodeDelimiter = {link = 'mkdBold'},
	mkdCodeEnd = {link = 'mkdCodeStart'},
	mkdCodeStart = {link = 'mkdCodeDelimiter'},
	mkdDelimiter = {link = 'Delimiter'},
	mkdHeading = {link = 'Delimiter'},
	mkdItalic = {link = 'mkdBold'},
	mkdLineBreak = {link = 'NonText'},
	mkdLink = {link = 'Underlined'},
	mkdListItem = {link = 'Special'},
	mkdRule = function(self) return {fg = self.Ignore.fg, sp = self.Delimiter.fg, underline = true} end,
	mkdURL = {link = 'htmlString'},

	-- PlantUML
	plantumlArrowLR = {link = 'Statement'},
	plantumlColonLine = {},
	plantumlMindmap = {link = 'Label'},
	plantumlMindmap2 = {link = 'Label'},

	-- Rust
	['@lsp.mod.callable.rust'] = {link = '@lsp.type.function'},
	['@lsp.type.builtinType.rust'] = {link = '@lsp.type.type'},
	['@lsp.type.character.rust'] = {},
	['@lsp.type.decorator.rust'] = {link = '@preproc'},
	['@lsp.type.derive.rust'] = {link = '@macro'},
	['@lsp.type.enumMember.rust'] = {},
	['@lsp.type.macro.rust'] = {},
	['@lsp.type.operator.rust'] = {},
	['@lsp.type.selfKeyword.rust'] = {link = '@keyword'},
	['@lsp.type.selfTypeKeyword.rust'] = {link = '@lsp.type.typeAlias.rust'},
	['@lsp.type.string.rust'] = {},
	['@lsp.type.typeAlias.rust'] = {link = '@type.definition'},
	['@lsp.typemod.character.injected.rust'] = {link = '@lsp.type.character'},
	['@lsp.typemod.deriveHelper.attribute.rust'] = {link = '@lsp.type.decorator.rust'},
	['@lsp.typemod.keyword.injected.rust'] = {link = '@keyword'},
	['@lsp.typemod.macro.injected.rust'] = {link = '@macro'},
	['@lsp.typemod.operator.injected.rust'] = {link = '@operator'},
	['@lsp.typemod.string.injected.rust'] = {link = '@lsp.type.string'},
	rustAssert = {link = 'Debug'},
	rustCharacterDelimiter = {link = 'rustNoise'},
	rustIdentifier = {link = 'Identifier'},
	rustStaticLifetime = {link = 'rustStorage'},
	rustStringDelimiter = {link = 'rustNoise'},

	-- Python
	pythonBrackets = {link = 'Delimiter'},
	pythonBuiltinFunc = {link = 'Operator'},
	pythonBuiltinObj = {link = 'Type'},
	pythonBuiltinType = {link = 'Type'},
	pythonClass = {link = 'Structure'},
	pythonClassParameters = {link = 'pythonParameters'},
	pythonDecorator = {link = 'PreProc'},
	pythonDottedName = {link = 'Identifier'},
	pythonError = {link = 'Error'},
	pythonException = {link = 'Exception'},
	pythonInclude = {link = 'Include'},
	pythonIndentError = {link = 'pythonError'},
	pythonLambdaExpr = {link = 'pythonOperator'},
	pythonOperator = {link = 'Operator'},
	pythonParam = {link = 'Identifier'},
	pythonParameters = {link = 'Delimiter'},
	pythonSelf = {link = 'Statement'},
	pythonSpaceError = {link = 'pythonError'},
	pythonStatement = {link = 'Statement'},

	-- Razor
	razorCode = {link = 'PreProc'},
	razorcsLHSMemberAccessOperator = {link = 'Noise'},
	razorcsRHSMemberAccessOperator = {link = 'razorcsLHSMemberAccessOperator'},
	razorcsStringDelimiter = {link = 'razorhtmlValueDelimiter'},
	razorcsTypeNullable = {link = 'Special'},
	razorcsUnaryOperatorKeyword = {link = 'Operator'},
	razorDelimiter = {link = 'Delimiter'},
	razorEventAttribute = {link = 'PreCondit'},
	razorFor = {link = 'razorIf'},
	razorhtmlAttribute = {link = 'htmlArg'},
	razorhtmlAttributeOperator = {link = 'Operator'},
	razorhtmlTag = {link = 'htmlTag'},
	razorhtmlValueDelimiter = {link = 'Delimiter'},
	razorIf = {link = 'PreCondit'},
	razorImplicitExpression = {link = 'PreProc'},
	razorLine = {link = 'Constant'},
	razorUsing = {link = 'Include'},

	-- Ruby
	rubyClass = {link = 'Structure'},
	rubyDefine = {link = 'Define'},
	rubyInterpolationDelimiter = {link = 'Delimiter'},

	-- Scala
	scalaKeyword = {link = 'Keyword'},
	scalaNameDefinition = {link = 'Identifier'},

	-- SCSS
	scssAmpersand = {link = 'Special'},
	scssAttribute = {link = 'Noise'},
	scssBoolean = {link = 'Boolean'},
	scssDefault = {link = 'Keyword'},
	scssDefinition = {link = 'PreProc'},
	scssElse = {link = 'scssIf'},
	scssIf = {link = 'PreCondit'},
	scssInclude = {link = 'Include'},
	scssMixinName = function(self)
		local definition = self.cssClassName
		return {bg = definition.bg, fg = definition.fg, italic = true}
	end,
	scssSelectorChar = {link = 'Delimiter'},
	scssSelectorName = {link = 'Identifier'},
	scssVariable = {link = 'Define'},
	scssVariableAssignment = {link = 'Operator'},

	-- shell
	shDerefSimple = {link = 'SpecialChar'},
	shFunctionKey = {link = 'Function'},
	shLoop = {link = 'Repeat'},
	shParen = {link = 'Delimiter'},
	shQuote = {link = 'Delimiter'},
	shSet = {link = 'Statement'},
	shTestOpr = {link = 'Debug'},

	-- SQL
	sqlKeyword = {link = 'Keyword'},
	sqlParen = {link = 'Delimiter'},
	sqlSpecial = {link = 'Constant'},
	sqlStatement = {link = 'Statement'},
	sqlParenFunc = {link = 'Function'},

	-- Solidity
	solBuiltinType = {link = 'Type'},
	solContract = {link = 'Typedef'},
	solContractName = {link = 'Function'},

	-- TeX
	texMathRegion = {link = 'Number'},
	texMathSub = {link = 'Number'},
	texMathSuper = {link = 'Number'},
	texMathRegionX = {link = 'Number'},
	texMathRegionXX = {link = 'Number'},

	-- TOML
	tomlComment = {link = 'Comment'},
	tomlDate = {link = 'Special'},
	tomlFloat = {link = 'Float'},
	tomlKey = {link = 'Label'},
	tomlTable = {link = 'Structure'},

	-- VimScript
	vimCmdSep = {link = 'Delimiter'},
	vimFunction = {link = 'Function'},
	vimFgBgAttrib = {link = 'Constant'},
	vimHiCterm = {link = 'Label'},
	vimHiCtermFgBg = {link = 'vimHiCterm'},
	vimHiGroup = {link = 'Typedef'},
	vimHiGui = {link = 'vimHiCterm'},
	vimHiGuiFgBg = {link = 'vimHiGui'},
	vimHiKeyList = {link = 'Operator'},
	vimIsCommand = {link = 'Identifier'},
	vimOption = {link = 'Keyword'},
	vimScriptDelim = {link = 'Ignore'},
	vimSet = {link = 'String'},
	vimSetEqual = {link = 'Operator'},
	vimSetSep = {link = 'Delimiter'},
	vimUserFunc = {link = 'vimFunction'},

	-- XML
	xmlAttrib = {link = 'htmlArg'},
	xmlEndTag = {link = 'xmlTag'},
	xmlEqual = {link = 'Operator'},
	xmlTag = {link = 'htmlTag'},
	xmlTagName = {link = 'htmlTagName'},

	-- XXD
	xxdAddress = {link = 'Label'},
	xxdAscii = {link = 'Character'},
	xxdDot = {link = 'Ignore'},
	xxdSep = {link = 'Delimiter'},

	-- YAML
	yamlInline = {link = 'Delimiter'},
	yamlKey = {link = 'Label'},

	--[[ Plugins
		Everything in this section is OPTIONAL. Feel free to remove everything
		here if you don't want to define it, or add more if there's something
		missing. ]]

	-- ALE
	ALEErrorSign = {link = 'DiagnosticSignError'},
	ALEWarningSign = {link = 'DiagnosticSignWarn'},

	-- barbar.nvim
	BufferAlternate = function(self) return {fg = self.BufferVisible.fg, bg = gray_dark} end,
	BufferAlternateERROR = function(self) return {fg = self.ErrorMsg.fg, bg = gray_dark} end,
	BufferAlternateHINT = function(self) return {fg = self.DiagnosticFloatingHint.fg, bg = gray_dark} end,
	BufferAlternateIndex = function(self) return {fg = self.Number.fg, bg = gray_dark} end,
	BufferAlternateINFO = function(self) return {fg = self.DiagnosticFloatingInfo.fg, bg = gray_dark} end,
	BufferAlternateMod = function(self) return {fg = self.BufferVisibleMod.fg, bg = gray_dark, bold = true} end,
	BufferAlternateSign = {fg = teal, bg = gray_dark},
	BufferAlternateTarget = function(self) return {fg = self.BufferAlternateSign.fg, bg = gray_dark, italic = true} end,
	BufferAlternateWARN = function(self) return {fg = self.WarningMsg.fg, bg = gray_dark} end,

	BufferCurrent = {link = 'TabLineSel'},
	BufferCurrentERROR = function(self) return {fg = self.ErrorMsg.fg, bg = self.BufferCurrent.bg} end,
	BufferCurrentHINT = function(self) return {fg = self.DiagnosticFloatingHint.fg, bg = self.BufferCurrent.bg} end,
	BufferCurrentIndex = function(self) return {fg = self.Number.fg, bg = self.BufferCurrent.bg} end,
	BufferCurrentINFO = function(self) return {fg = self.DiagnosticFloatingInfo.fg, bg = self.BufferCurrent.bg} end,
	BufferCurrentMod = {fg = tan, bg = black, bold = true},
	BufferCurrentSign = {link = 'DiagnosticFloatingHint'},
	BufferCurrentTarget = {link = 'BufferCurrentSign'},
	BufferCurrentWARN = function(self) return {fg = self.WarningMsg.fg, bg = self.BufferCurrent.bg} end,

	BufferInactive = {link = 'BufferVisible'},
	BufferInactiveERROR = function(self) return {fg = self.ErrorMsg.fg, bg = self.BufferInactive.bg} end,
	BufferInactiveHINT = function(self) return {fg = self.DiagnosticFloatingHint.fg, bg = self.BufferInactive.bg} end,
	BufferInactiveIndex = function(self) return {fg = self.Number.fg, bg = self.BufferInactive.bg} end,
	BufferInactiveINFO = function(self) return {fg = self.DiagnosticFloatingInfo.fg, bg = self.BufferInactive.bg} end,
	BufferInactiveMod = {link = 'BufferVisibleMod'},
	BufferInactiveSign = {link = 'BufferVisibleSign'},
	BufferInactiveTarget = {link = 'BufferVisibleTarget'},
	BufferInactiveWARN = function(self) return {fg = self.WarningMsg.fg, bg = self.BufferInactive.bg} end,

	BufferTabpages = {bold = true},
	BufferTabpageFill = {link = 'TabLineFill'},

	BufferVisible = {link = 'TabLine'},
	BufferVisibleERROR = function(self) return {fg = self.ErrorMsg.fg, bg = self.BufferVisible.bg} end,
	BufferVisibleHINT = function(self) return {fg = self.DiagnosticFloatingHint.fg, bg = self.BufferVisible.bg} end,
	BufferVisibleIndex = function(self) return {fg = self.Number.fg, bg = self.BufferVisible.bg} end,
	BufferVisibleINFO = function(self) return {fg = self.DiagnosticFloatingInfo.fg, bg = self.BufferVisible.bg} end,
	BufferVisibleMod = function(self) return {fg = white, bg = self.BufferVisible.bg, italic = true} end,
	BufferVisibleSign = function(self)
		local definition = self.BufferVisibleMod
		return {fg = definition.fg, bg = definition.bg, bold = true}
	end,
	BufferVisibleTarget = {link = 'BufferVisibleSign'},
	BufferVisibleWARN = function(self) return {fg = self.WarningMsg.fg, bg = self.BufferVisible.bg} end,

	-- coc.nvim
	CocErrorHighlight = {link = 'DiagnosticUnderlineError'},
	CocErrorSign = {link = 'DiagnosticSignError'},
	CocHintHighlight = {link = 'DiagnosticUnderlineHint'},
	CocHintSign = {link = 'DiagnosticSignHint'},
	CocInfoHighlight = {link = 'DiagnosticUnderlineInfo'},
	CocInfoSign = {link = 'DiagnosticSignInfo'},
	CocWarningHighlight = {link = 'DiagnosticUnderlineWarn'},
	CocWarningSign = {link = 'DiagnosticSignWarn'},

	-- Fern
	FernBranchText = {link = 'Directory'},

	-- gitsigns.nvim
	GitSignsAdd = {link = 'GitGutterAdd'},
	GitSignsChange = {link = 'GitGutterChange'},
	GitSignsDelete = {link = 'GitGutterDelete'},

	-- indent-blankline.nvim
	IndentBlanklineChar = function(self)
		local definition = vim.deepcopy(self.Whitespace)
		definition.nocombine = true
		return definition
	end,
	IndentBlanklineSpaceChar = {link = 'IndentBlanklineChar'},

	-- lazy.nvim
	LazyButton = {link = 'TabLine'},
	LazyButtonActive = {link = 'TabLineSel'},
	LazyCommit = {link = 'Number'},
	LazyCommitIssue = {link = 'LazyUrl'},
	LazyCommitType = {link = 'Type'},
	LazyDir = {link = 'Directory'},
	LazyH1 = {link = 'markdownH1'},
	LazyH2 = {link = 'markdownH2'},
	LazyProp = {link = '@field'},
	LazyReasonEvent = {link = 'Repeat'},
	LazyReasonFt = {link = 'Conditional'},
	LazyReasonImport = {link = 'Function'},
	LazyReasonKeys = {link = 'String'},
	LazyReasonPlugin = {link = 'Label'},
	LazyReasonSource = {link = 'Include'},
	LazyReasonStart = {link = 'Constant'},
	LazySpecial = {link = 'Special'},
	LazyTaskOutput = {link = 'Statement'},
	LazyUrl = {link = 'Underlined'},

	-- LSPSaga
	DefinitionCount = {link = 'Number'},
	DefinitionIcon = {link = 'Special'},
	ReferencesCount = {link = 'Number'},
	ReferencesIcon = {link = 'DefinitionIcon'},
	TargetFileName = {link = 'Directory'},
	TargetWord = {link = 'Title'},

	-- mini.nvim
	MiniJump = {link = 'MiniJump2dSpot'},

	-- NERDTree
	NERDTreeCWD = {link = 'Label'},
	NERDTreeUp = {link = 'Operator'},
	NERDTreeDir = {link = 'Directory'},
	NERDTreeDirSlash = {link = 'Delimiter'},
	NERDTreeOpenable = {link = 'NERDTreeDir'},
	NERDTreeClosable = {link = 'NERDTreeOpenable'},
	NERDTreeExecFile = {link = 'Function'},
	NERDTreeLinkTarget = {link = 'Tag'},

	-- nvim-cmp
	CmpItemAbbr = {link = 'Ignore'},
	CmpItemAbbrMatch = {link = 'Underlined'},
	CmpItemAbbrMatchFuzzy = function(self) return {fg = self.Normal.fg, nocombine = true, underline = true} end,
	CmpItemKindClass = {link = 'CmpItemKindStruct'},
	CmpItemKindsp = {link = 'Label'},
	CmpItemKindConstant = {link = 'Constant'},
	CmpItemKindConstructor = {link = 'CmpItemKindMethod'},
	CmpItemKind = {link = 'Type'},
	CmpItemKindEnum = {link = 'CmpItemKindStruct'},
	CmpItemKindEnumMember = {link = 'CmpItemKindConstant'},
	CmpItemKindEvent = {link = 'Repeat'},
	CmpItemKindField = {link = 'Identifier'},
	CmpItemKindFile = {link = 'Directory'},
	CmpItemKindFolder = {link = 'CmpItemKindFile'},
	CmpItemKindFunction = {link = 'Function'},
	CmpItemKindInterface = {link = 'Type'},
	CmpItemKindKeyword = {link = 'Keyword'},
	CmpItemKindMethod = {link = 'CmpItemKindFunction'},
	CmpItemKindModule = {link = 'Include'},
	CmpItemKindOperator = {link = 'Operator'},
	CmpItemKindProperty = {link = 'CmpItemKindField'},
	CmpItemKindReference = {link = 'StorageClass'},
	CmpItemKindSnippet = {link = 'Special'},
	CmpItemKindStruct = {link = 'Structure'},
	CmpItemKindText = {link = 'String'},
	CmpItemKindTypeParameter = {link = 'Typedef'},
	CmpItemKindUnit = {link = 'CmpItemKindStruct'},
	CmpItemKindValue = {link = 'CmpItemKindConstant'},
	CmpItemKindVariable = {link = 'Identifier'},

	-- nvim-tree
	NvimTreeGitDeleted = function(self) return {fg = self.DiffDelete.bg} end,
	NvimTreeGitDirty = {fg = orange},
	NvimTreeGitIgnored = {link = 'Ignore'},
	NvimTreeGitMerge = {link = 'NvimTreeGitRenamed'},
	NvimTreeGitNew = function(self) return {fg = self.DiffAdd.bg} end,
	NvimTreeGitRenamed = function(self) return {fg = self.DiffChange.bg} end,
	NvimTreeGitStaged = {fg = cyan},

	-- packer.nvim
	packerFail = {link = 'ErrorMsg'},
	packerHash = {link = 'Number'},
	packerPackageNotLoaded = {link = 'Ignore'},
	packerStatusFail = {link = 'Statement'},
	packerStatusSuccess = {link = 'packerStatusFail'},
	packerSuccess = function(self)
		local definition = vim.deepcopy(self.packerFail)
		definition.bg = nil
		definition.fg = green
		return definition
	end,

	-- symbols-outline.nvim
	FocusedSymbol = {},
	SymbolsOutlineConnector = {link = 'Delimiter'},

	-- todo-comments.nvim
	TodoFgFIX = function(self) return {fg = self.ErrorMsg.fg} end,
	TodoFgHACK = {fg = yellow},
	TodoFgNOTE = {link = 'DiagnosticFloatingHint'},
	TodoFgPERF = {link = 'DiagnosticFloatingInfo'},
	TodoFgTODO = function(self) return {fg = self.Todo.bg, italic = true} end,
	TodoFgWARN = function(self) return {fg = self.WarningMsg.fg} end,

	TodoBgFIX = function(self) return {fg = black, bg = self.TodoFgFIX.fg, bold = true, italic = true, nocombine = true} end,
	TodoBgHACK = function(self) return {fg = black, bg = self.TodoFgHACK.fg, bold = true, italic = true, nocombine = true} end,
	TodoBgNOTE = function(self) return {fg = black, bg = self.TodoFgNOTE.fg, bold = true, italic = true, nocombine = true} end,
	TodoBgPERF = function(self) return {fg = black, bg = self.TodoFgPERF.fg, bold = true, italic = true, nocombine = true} end,
	TodoBgTODO = function(self) return {fg = black, bg = self.TodoFgTODO.fg, bold = true, italic = true, nocombine = true} end,
	TodoBgWARN = function(self) return {fg = black, bg = self.TodoFgWARN.fg, bold = true, italic = true, nocombine = true} end,

	TodoSignFIX = {link = 'TodoFgFIX'},
	TodoSignHACK = {link = 'TodoFgHACK'},
	TodoSignNOTE = {link = 'TodoFgNOTE'},
	TodoSignPERF = {link = 'TodoFgPERF'},
	TodoSignTODO = {link = 'TodoFgTODO'},
	TodoSignWARN = {link = 'TodoFgWARN'},

	-- trouble.nvim
	TroubleCount = function(self)
		local definition = vim.deepcopy(self.Number)
		definition.underline = true
		return definition
	end,

	-- vim-easymotion
	EasyMotion = {link = 'IncSearch'},

	-- vim-gitgutter
	GitGutterAdd = {fg = green},
	GitGutterChange = {fg = yellow},
	GitGutterDelete = {fg = red},
	GitGutterChangeDelete = {fg = orange},

	-- vim-indent-guides
	IndentGuidesOdd = {bg = gray_darker},
	IndentGuidesEven = {bg = gray},

	-- vim-jumpmotion
	JumpMotion = {link = 'EasyMotion'},

	-- vim-sandwhich
	OperatorSandwichChange = {link = 'DiffText'},

	-- vim-signify
	SignifySignAdd = {link = 'GitGutterAdd'},
	SignifySignChange = {link = 'GitGutterChange'},
	SignifySignDelete = {link = 'GitGutterDelete'},
	SignifySignChangeDelete = {link = 'GitGutterChangeDelete'},
}

--[[ Step 5: Terminal Colors
	Define the color palette used by :terminal when in GUI Vim
	or in TUI Vim when 'termguicolors' is enabled. If this list
	is empty or if it doesn't contain exactly 16 items, the corresponding
	Vim variable won't be set.

	The expected values are colors defined in step 3.

	Terminal emulators use a basic palette of 16 colors that can be
	addressed by CLI and TUI tools via their name or their index, from
	0 to 15. The list is not really standardized but it is generally
	assumed to look like this:

	 | Index  | Name          |
	 |:------:|:-------------:|
	 | 1      | black         |
	 | 2      | darkred       |
	 | 3      | darkgreen     |
	 | 4      | darkyellow    |
	 | 5      | darkblue      |
	 | 6      | darkmagenta   |
	 | 7      | darkcyan      |
	 | 8      | gray          |
	 | 9      | darkgray      |
	 | 10     | red           |
	 | 11     | green         |
	 | 12     | yellow        |
	 | 13     | blue          |
	 | 14     | magenta       |
	 | 15     | cyan          |
	 | 16     | white         |

	While you are certainly free to make colors 0 to 7 shades of blue,
	this will inevitably cause usability issues so… be careful.
]]

colorscheme.highlight_terminal {
	[1] = black,
	[2] = red_dark,
	[3] = green_dark,
	[4] = orange,
	[5] = blue,
	[6] = magenta_dark,
	[7] = teal,
	[8] = gray,
	[9] = gray_dark,
	[10] = red,
	[11] = green,
	[12] = yellow,
	[13] = turqoise,
	[14] = purple,
	[15] = cyan,
	[16] = gray_light,
}

--[[ Step 5: Sourcing
	When you wish to load your colorscheme, simply add this folder with a plugin manager
	and then use `colorscheme <your colorscheme name>`. For example, in my configuration,
	I source highlite by using `colorscheme highlite`.

	These online resources can help you design your colorscheme:

	1. the xterm palette.
		* http://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg
	2. play with hexadecimal colors right in the address bar (currently down).
		* http://whatcolor.herokuapp.com/
	3. similar concept, fuzzier implementation.
		* http://color.hailpixel.com/
	4. similar concept, fancier implementation.
		* http://colourco.de/
	5. extract a palette from an image.
		* http://www.colr.org/
	6. search for 'word', get images and color palettes.
		* http://colores.manugarri.com/
	7. user-created palettes.
		* http://www.colourlovers.com/palettes
	8. a no-nonsense colorscheme generator.
		* http://www.pluaang.dk/color+scheme/
	9. Adobe's fancy colorscheme generator.
		* https://color.adobe.com/
	10. The classic 'Color Scheme Designer', rebranded.
		* http://paletton.com/
	11. A very smart palette generator.
		* http://vrl.cs.brown.edu/color
	12. 'I Made My Own Colour Scheme and You Can Too!'.
		* https://cmcenroe.me/2018/04/03/colour-scheme.html

	A few things to note:

	* The Windows console (`cmd`) is limited to the 16 so-called 'ANSI' colors but it used to
			have a few of them interverted which makes numbers impractical. Use color names
			instead of numbers: :help cterm-colors
		* The Windows console doesn't do italics, underlines or bolded text;
			it is limited to normal and reverse. Keep that in mind if you want
			your colorscheme to be usable in as many environments as possible by as many
			people as possible.
		* The Windows TERMINAL, however, is capable of more.
	* All of the terminal emulators in use these days allow their users to
		change the 16 so-called 'ANSI' colors. It is also possible on some platforms
		to change some or all of the 256 colors in the xterm palette. Don't take
		anything for granted.
	* When used against a light background, strong colors work better than muted
		ones. Light or dark doesn't really matters. Also, it is harder to discriminate
		between two similar colors on a light background.
	* Both strong and muted colors work well against a dark background. It is also
		easier to work with similar colors, but dark colors don't work at all.
	* Use as many text samples as possible. String-heavy languages may look completely
		different than keyword-heavy ones. This can have an impact on the usability
		of your colorscheme.
	* Most terminal emulators and terminal multiplexers currently in use on unix-like
		systems support 256 colors but they almost always default to a '$TERM' that tells
		Vim otherwise. Your users will need to make sure their terminal emulator/multiplexer
		is correctly set up if they want to enjoy the best possible experience.
]]

-- Thanks to Romain Lafourcade (https://github.com/romainl) for the original template (romainl/vim-rnb).
