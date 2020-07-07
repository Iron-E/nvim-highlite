" This file should be edited by the user.
" Read the instructions of each section and then edit them as desired.
lua << EOF
--[[ Highlite, a Neovim colorscheme template.
	* Author:     Iron-E (https://github.com/Iron-E)
	* Repository: https://github.com/nvim-highlite

	Rewrite of RNB, a Vim colorsheme template.
	* Author:        Romain Lafourcade (https://github.com/romainl)
	* Canonical URL: https://github.com/romainl/vim-rnb
]]

--[[ Introduction
	This template is designed to help Neovim users create their own colorschemes without much effort.

	You will not need any additional tooling to run this file. Just open it in Neovim and follow the instructions.

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
	| foo-bar           | foo_bar     | foo-bar.lua       |
	| foo bar           | foo_bar     | foo-bar.lua or    |
	| foo_bar           | foo_bar     | foo_bar.lua       |

	Rename the following files:
	* `colors/highlite.vim`
	* `lua/highlite.lua`

	Where 'highlite' is the name of your colorscheme.
]]

--[[ Step 2: Information
	This is the name of your colorscheme which will be used as per |g:colors_name|.
]]

vim.g.colors_name = 'highlite'

--[[ Step 3: Colors
	Next you will define all of the colors that you will use for the color scheme.

	Each one should be made up of three parts:

```lua
	<color name> = { -- Give each color a distinctive name.
		'#<hex color code>', -- Hexadecimal color used in GVim/MacVim or 'NONE'.
		<256-bit color code>, -- Integer 0–255 used by terminals supporting 256 colors or 'NONE'.
		'<16-bit color code>' -- color name used by less capable color terminals, can be 'darkred',
		                       'red', 'darkgreen', 'green', 'darkyellow', 'yellow', 'darkblue',
		                       'blue', 'darkmagenta', 'magenta', 'black', 'darkgrey', 'grey',
		                       'white', or 'NONE'
	}
```

	If your colors are defined correctly, the resulting colorscheme is guaranteed
	to work in GVim (Windows/Linux), MacVim (MacOS), and any properly set up terminal emulator.

	NOTE: |Replace-mode| will probably be useful here.
]]

local black = {'#202020', 0,   'black'}
local gray  = {'#808080', 244, 'gray' }
local gray_dark   = {'#353535', 236, 'darkgrey'}
local gray_darker = {'#505050', 244, 'gray'}
local gray_light  = {'#c0c0c0', 251, 'gray'}
local white = {'#ffffff', 15, 'white'}

local tan         = {'#f4c069', 180, 'darkyellow'}

local red       = {'#ee4a59', 196, 'red'}
local red_dark  = {'#a80000', 124, 'darkred'}
local red_light = {'#ff4090', 203, 'red'}

local orange = {'#ff8900', 208, 'darkyellow'}
local orange_light = {'#f0af00', 214, 'yellow'}

local yellow = {'#f0df33', 220, 'yellow'}

local green_dark  = {'#50de60', 83, 'darkgreen'}
local green       = {'#77ff00', 72, 'green'}
local green_light = {'#a0ff70', 72, 'green'}

local blue     = {'#7090ff', 63, 'darkblue'}
local cyan     = {'#00efff', 87, 'cyan'}
local ice      = {'#80b5ff', 63, 'cyan'}
local teal     = {'#6ac0c0', 38, 'cyan'}
local turqoise = {'#2bff99', 33, 'blue'}

local magenta      = {'#d5508f', 126, 'magenta'}
local magenta_dark = {'#bb0099', 126, 'darkmagenta'}
local pink         = {'#ffa6ff', 162, 'magenta'}
local pink_light   = {'#ffb7b7', 38,  'white'}
local purple       = {'#cf55f0', 129, 'magenta'}
local purple_light = {'#af60af', 63,  'magenta'}

--[[ Step 4: highlights
	You can define highlight groups like this:

```lua
	<highlight group name> = {
		bg=<color>, -- The color used for background color, or use 'NONE', 'fg' or 'bg'
		fg=<color>, -- The color used for foreground color, or use 'NONE', 'fg' or 'bg'
		-- Style can be 'bold', 'italic', and more. See |attr-list| for more information. It can also have a color, and/or multiple <cterm>s.
		style=<cterm>|{<cterm> [, <cterm>] [color=<color>]})
	}
```

	Or you can link an highlight group to another.

```lua
	<highlight group name> = {link='<highlight group name>'}
```

	Here is an example:

```lua
	SpellBad = { -- ← name of the highlight group
		bg='NONE', -- background color
		fg=red, -- foureground color
		style={ -- the style
			'undercurl', -- undercurl (squiggly line)
			color=red -- the color of the undercurl
		}
	}
```

	If you weren't satisfied with undercurl, and also wanted another effect, you can
	add another one below 'undercurl' and it will be applied as well:

```lua
	SpellBad = { -- ← name of the highlight group
		bg='NONE', -- background color
		fg=red, -- foureground color
		style={ -- the style
			'undercurl', -- undercurl (squiggly line)
			'standout'
			color=red -- the color of the undercurl
		}
	}
```

	You can add any custom highlight group to the standard list below but you shouldn't
	remove any if you want a working colorscheme. Most of them are described under
	|highlight-default|, some from |group-name|, and others from common syntax groups.
	Both help sections are good reads.

	NOTE: |Replace-mode| will probably be useful here.

	NOTE: /As long as you do not remove any highlight groups or colors/, you can safely
	      ignore any highlight groups that are `link`ed others.
	      For example, programming languages almost exclusively link to the 1st
	      and 2nd sections, so as long as you define everything there you will automatically
	      be defining the rest of the highlights, which is one of the benefits of using
	      this template.
]]

--[[ DO NOT EDIT `BG`, `FG`, or `NONE`.
	Feel free to uncomment `BG`. It is not used by default so it is commented out.
]]
-- local BG   = 'bg'
local FG   = 'fg'
local NONE = 'NONE'

--[[ These are the ones you should edit. ]]
-- This is the only highlight that must be defined separately.
local highlight_group_normal = {bg=black, fg=gray_light, style=NONE}

-- This is where the rest of your highlights should go.
local highlight_groups = {
	--[[ 4.1. Text Analysis ]]
	Comment     = {bg=NONE,        fg=gray,         style='italic'},
	EndOfBuffer = {link='NonText'                                 },
	NonText     = {bg=NONE,        fg=gray_darker,  style=NONE    },
	Whitespace  = {link='NonText'                                 },

	--[[ 4.1.1. Literals]]
	Constant  = {bg=NONE,       fg=orange_light,  style=NONE},
	String    = {bg=NONE,       fg=green,         style=NONE},
	Character = {bg=NONE,       fg=red_light,     style=NONE},
	Number    = {bg=NONE,       fg=pink_light,    style=NONE},
	Boolean   = {bg=NONE,       fg=yellow,        style=NONE},
	Float     = {link='Number'                              },

	--[[ 4.1.2. Identifiers]]
	Identifier = {bg=NONE, fg=FG,     style=NONE},
	Function   = {bg=NONE, fg=purple, style=NONE},

	--[[ 4.1.3. Syntax]]
	Statement   = {bg=NONE,        fg=ice,         style=NONE    },
	Conditional = {bg=NONE,        fg=ice,         style='italic'},
	Repeat      = {link='Keyword'                                },
	Label       = {bg=NONE,        fg=pink,        style='italic'},
	Operator    = {bg=NONE,        fg=green_dark,  style=NONE    },
	Keyword     = {bg=NONE,        fg=turqoise,    style='bold'  },
	Exception   = {bg=NONE,        fg=red_light,   style='bold'  },

	--[[ 4.1.4. Metatextual Information]]
	PreProc   = {bg=NONE,      fg=tan,          style=NONE       },
	Include   = {bg=NONE,      fg=green_light,  style='nocombine'},
	Define    = {bg=NONE,      fg=blue,         style='nocombine'},
	Macro     = {link='Define'                                   },
	PreCondit = {bg=NONE,      fg=teal,         style='nocombine'},

	--[[ 4.1.5. Semantics]]
	Type         = {bg=NONE,  fg=cyan,          style=NONE    },
	StorageClass = {bg=NONE,  fg=orange_light,  style='bold'  },
	Structure    = {bg=NONE,  fg=blue,          style='bold'  },
	Typedef      = {bg=NONE,  fg=cyan,          style='italic'},

	--[[ 4.1.6. Edge Cases]]
	Special        = {bg=NONE,           fg=magenta,  style=NONE                 },
	SpecialChar    = {link='Character'                                           },
	SpecialKey     = {link='Character'                                           },
	Tag            = {link='Underlined'                                          },
	Delimiter      = {bg=NONE,           fg=white,    style=NONE                 },
	SpecialComment = {bg=NONE,           fg=gray,     style={'bold', 'nocombine'}},
	Debug          = {link='WarningMsg'                                          },

	--[[ 4.1.7. Help Syntax]]
	Underlined        = {bg=NONE,           fg=turqoise,  style='underline'          },
	Ignore            = {bg=NONE,           fg=gray,      style=NONE                 },
	Error             = {bg=red_dark,       fg=white,     style='bold'               },
	Todo              = {bg=NONE,           fg=yellow,    style={'bold', 'underline'}},
	helpHyperTextJump = {link='Underlined'                                           },
	helpSpecial       = {link='Function'                                             },
	Hint              = {bg=magenta,        fg=black,     style='bold'               },
	Info              = {bg=pink_light,     fg=black,     style='bold'               },
	Warning           = {bg=orange,         fg=black,     style='bold'               },

	--[[ 4.2... Editor UI  ]]
	--[[ 4.2.1. Status Line]]
	StatusLine       = {bg=gray_darker,        fg=green_light,  style=NONE},
	StatusLineNC     = {bg=gray_darker,        fg=gray,         style=NONE},
	StatusLineTerm   = {link='StatusLine'                                 },
	StatusLineTermNC = {link='StatusLineNC'                               },

	--[[ 4.2.2. Separators]]
	VertSplit   = {bg=NONE,         fg=gray_darker,  style=NONE     },
	TabLine     = {bg=gray_darker,  fg=FG,           style=NONE     },
	TabLineFill = {bg=NONE,         fg=FG,           style=NONE     },
	TabLineSel  = {bg=gray_darker,  fg=FG,           style='inverse'},
	Title       = {bg=NONE,         fg=NONE,         style='bold'   },

	--[[ 4.2.3. Conditional Line Highlighting]]
	--Conceal={}
	CursorLine      = {bg=gray_dark,       fg=NONE,  style=NONE     },
	CursorLineNr    = {bg=gray_dark,       fg=pink,  style=NONE     },
	debugBreakpoint = {link='ErrorMsg'                              },
	debugPC         = {link='ColorColumn'                           },
	LineNr          = {bg=NONE,            fg=gray,  style=NONE     },
	QuickFixLine    = {bg=gray_darker,     fg=NONE,  style=NONE     },
	Visual          = {bg=NONE,            fg=NONE,  style='inverse'},
	VisualNOS       = {bg=gray_darker,     fg=NONE,  style=NONE     },

	--[[ 4.2.4. Popup Menu]]
	Pmenu      = {bg=gray_dark,  fg=FG,    style=NONE},
	PmenuSbar  = {bg=black,      fg=NONE,  style=NONE},
	PmenuSel   = {bg=NONE,       fg=FG,    style=NONE},
	PmenuThumb = {bg=white,      fg=NONE,  style=NONE},
	WildMenu   = {bg=NONE,       fg=NONE,  style=NONE},

	--[[ 4.2.5. Folds]]
	FoldColumn = {bg=gray_darker,   fg=NONE,   style='bold'  },
	Folded     = {bg=purple_light,  fg=black,  style='italic'},

	--[[ 4.2.6. Diffs]]
	DiffAdd    = {bg=NONE,  fg=green_dark,  style='inverse'},
	DiffChange = {bg=NONE,  fg=yellow,      style='inverse'},
	DiffDelete = {bg=NONE,  fg=red,         style='inverse'},
	DiffText   = {bg=NONE,  fg=NONE,        style='inverse'},

	--[[ 4.2.7. Searching]]
	IncSearch  = {bg=NONE,  fg=NONE,   style='inverse'                 },
	Search     = {bg=NONE,  fg=NONE,   style={'underline', color=white}},
	MatchParen = {bg=NONE,  fg=green,  style={'bold', 'underline'     }},

	--[[ 4.2.8. Spelling]]
	SpellBad   = {bg=NONE,  fg=NONE,  style={'undercurl', color=red   }},
	SpellCap   = {bg=NONE,  fg=NONE,  style={'undercurl', color=yellow}},
	SpellLocal = {bg=NONE,  fg=NONE,  style={'undercurl', color=green }},
	SpellRare  = {bg=NONE,  fg=NONE,  style={'undercurl', color=orange}},

	--[[ 4.2.9. Conditional Column Highlighting]]
	ColorColumn = {bg=NONE,  fg=NONE,  style='inverse'},
	SignColumn  = {bg=NONE,  fg=NONE,  style=NONE     },

	--[[ 4.2.10. Messages]]
	ErrorMsg   = {bg=NONE,  fg=red,          style='bold'     },
	HintMsg    = {bg=NONE,  fg=magenta,      style='bold'     },
	InfoMsg    = {bg=NONE,  fg=pink_light,   style='bold'     },
	ModeMsg    = {bg=NONE,  fg=yellow,       style=NONE       },
	WarningMsg = {bg=NONE,  fg=orange,       style='bold'     },
	Question   = {bg=NONE,  fg=orange_light, style='underline'},

	--[[ 4.2.11. LSP ]]
	LspDiagnosticsError = {link='Error'           },
	LspDiagnosticsErrorFloating = {link='ErrorMsg'},
	LspDiagnosticsErrorSign = {link='ErrorMsg'    },

	LspDiagnosticsWarning = {link='Warning'           },
	LspDiagnosticsWarningFloating = {link='WarningMsg'},
	LspDiagnosticsWarningSign = {link='WarningMsg'    },

	LspDiagnosticsHint = {link='Hint'           },
	LspDiagnosticsHintFloating = {link='HintMsg'},
	LspDiagnosticsHintSign = {link='HintMsg'    },

	LspDiagnosticsInformation = {link='Info'           },
	LspDiagnosticsInformationFloating = {link='InfoMsg'},
	LspDiagnosticsInformationSign = {link='InfoMsg'    },

	LspDiagnosticsUnderline = {bg=NONE, fg=NONE, style={'undercurl', color=white}},
	LspDiagnosticsUnderlineError = {link='CocErrorHighlight'    },
	LspDiagnosticsUnderlineHint = {link='CocHintHighlight'      },
	LspDiagnosticsUnderlineInfo = {link='CocInfoHighlight'      },
	LspDiagnosticsUnderlineWarning = {link='CocWarningHighlight'},

	--[[ 4.2.12. Cursor ]]
	Cursor   = {bg=NONE,           fg=NONE,  style='inverse'},
	CursorIM = {link='Cursor'                               },
	CursorColumn = {bg=gray_dark,  fg=NONE,  style=NONE     },

	--[[ 4.2.13. Misc ]]
	Directory     = {bg=NONE,       fg=ice,  style='bold'},
	Terminal      = {link='Normal'                       },

	--[[ 4.3. Programming Languages
		Everything in this section is OPTIONAL. Feel free to remove everything
		here if you don't want to define it, or add more if there's something
		missing.
	]]
	--[[ 4.3.1. C ]]
	cConstant    = {link='Constant'},
	cCustomClass = {link='Type'    },

	--[[ 4.3.2. C++ ]]
	cppSTLexception = {link='Exception'},
	cppSTLnamespace = {link='String'   },

	--[[ 4.3.3 C# ]]
	csLogicSymbols = {link='Operator'},

	--[[ 4.3.4. CSS ]]
	cssProp    = {link='Keyword'},
	cssTagName = {link='Type'   },

	--[[ 4.3.5. Dart ]]
	dartLibrary = {link='Statement'},

	--[[ 4.3.6. dot ]]
	dotKeyChar = {link='Character'},
	dotType    = {link='Type'     },

	--[[ 4.3.7. Go ]]
	goBlock                 = {link='Delimiter'            },
	goBoolean               = {link='Boolean'              },
	goBuiltins              = {link='Operator'             },
	goField                 = {link='Identifier'           },
	goFloat                 = {link='Float'                },
	goFormatSpecifier       = {link='Character'            },
	goFunction              = {link='Function'             },
	goFunctionCall          = {link='goFunction'           },
	goFunctionReturn        = {bg=NONE, fg=NONE, style=NONE},
	goMethodCall            = {link='goFunctionCall'       },
	goParamType             = {link='goReceiverType'       },
	goPointerOperator       = {link='SpecialChar'          },
	goPredefinedIdentifiers = {link='Constant'             },
	goReceiver              = {link='goBlock'              },
	goReceiverType          = {link='goTypeName'           },
	goSimpleParams          = {link='goBlock'              },
	goType                  = {link='Type'                 },
	goTypeConstructor       = {link='goFunction'           },
	goTypeName              = {link='Type'                 },
	goVarAssign             = {link='Identifier'           },
	goVarDefs               = {link='goVarAssign'          },

	--[[ 4.3.8. HTML ]]
	htmlBold   = {bg=NONE, fg=NONE, style='bold'  },
	htmlItalic = {bg=NONE, fg=NONE, style='italic'},
	htmlSpecialTagName = {link='Tag'              },

	--[[ 4.3.9. Java ]]
	javaClassDecl = {link='Structure'},

	--[[ 4.3.10. JavaScript ]]
	jsFuncBlock   = {link='Function'  },
	jsObjectKey   = {link='Type'      },
	jsReturn      = {link='Keyword'   },
	jsVariableDef = {link='Identifier'},

	--[[ 4.3.11. JSON ]]
	jsonStringSQError = {link='Exception'},

	--[[ 4.3.12. Make ]]
	makeCommands   = {link='Statment'},
	makeSpecTarget = {link='Type'    },

	--[[ 4.3.13. Markdown ]]
	markdownH1          = {bg=NONE,          fg=green_dark,  style='bold'  },
	markdownH2          = {bg=NONE,          fg=red_light,   style='bold'  },
	markdownH3          = {bg=NONE,          fg=green,       style='bold'  },
	markdownH4          = {bg=NONE,          fg=magenta,     style='bold'  },
	markdownH5          = {bg=NONE,          fg=orange,      style='bold'  },
	markdownH6          = {bg=NONE,          fg=yellow,      style='bold'  },
	mkdBold             = {bg=NONE,          fg='green',     style='bold'  },
	mkdCode             = {link='Comment'                                  },
	mkdCodeDelimiter    = {link='Delimiter'                                },
	mkdItalic           = {bg=NONE,          fg=green,       style='italic'},
	mkdListItem         = {link='Special'                                  },
	mkdNonListItemBlock = {link='Normal'                                   },
	texMathZoneY        = {link='String'                                   },

	--[[ 4.3.20. Python ]]
	pythonBrackets        = {link='Delimiter'       },
	pythonBuiltinFunc     = {link='Operator'        },
	pythonBuiltinObj      = {link='Type'            },
	pythonBuiltinType     = {link='Type'            },
	pythonClass           = {link='Structure'       },
	pythonClassParameters = {link='pythonParameters'},
	pythonDecorator       = {link='PreProc'         },
	pythonDottedName      = {link='Identifier'      },
	pythonError           = {link='Error'           },
	pythonException       = {link='Exception'       },
	pythonInclude         = {link='Include'         },
	pythonIndentError     = {link='pythonError'     },
	pythonLambdaExpr      = {link='pythonOperator'  },
	pythonOperator        = {link='Operator'        },
	pythonParam           = {link='Identifier'      },
	pythonParameters      = {link='Delimiter'       },
	pythonSelf            = {link='Statement'       },
	pythonSpaceError      = {link='pythonError'     },
	pythonStatement       = {link='Statement'       },

	--[[ 4.3.21. Ruby ]]
	rubyClass                  = {link='Structure'},
	rubyDefine                 = {link='Define'   },
	rubyInterpolationDelimiter = {link='Delimiter'},

	--[[ 4.3.22. Rust ]]
	rustKeyword   = {link='Keyword'     },
	rustModPath   = {link='Include'     },
	rustScopeDecl = {link='Delimiter'   },
	rustTrait     = {link='StorageClass'},

	--[[ 4.3.23. Scala ]]
	scalaKeyword        = {link='Keyword'   },
	scalaNameDefinition = {link='Identifier'},

	--[[ 4.3.24. shell ]]
	shFunctionKey = {link='Function' },
	shLoop        = {link='Repeat'   },
	shSet         = {link='Statement'},
	shTestOpr     = {link='Debug'    },

	--[[ 4.3.25. Solidity ]]
	solBuiltinType  = {link='Type'    },
	solContract     = {link='Typedef' },
	solContractName = {link='Function'},

	--[[ 4.3.26. TOML ]]
	tomlComment = {link='Comment'     },
	tomlKey     = {link='Label'       },
	tomlTable   = {link='StorageClass'},

	--[[ 4.3.27. VimScript ]]
	vimCommand   = {link = 'Keyword'   },
	vimFuncKey   = {link = 'Function'  },
	vimGroup     = {link = 'Type'      },
	vimHiGroup   = {link = 'Typedef'   },
	vimIsCommand = {link = 'vimCommand'},
	vimLet       = {link = 'Operator'  },
	vimMap       = {link = 'vimCommand'},

	--[[ 4.3.28. XML ]]
	xmlAttrib  = {link='Label'    },
	xmlEndTag  = {link='Exception'},
	xmlEqual   = {link='Operator' },
	xmlTag     = {link='Delimiter'},
	xmlTagName = {link='Define'   },

	--[[ 4.4. Plugins
		Everything in this section is OPTIONAL. Feel free to remove everything
		here if you don't want to define it, or add more if there's something
		missing.
	]]
	--[[ 4.4.1. ALE ]]
	ALEErrorSign   = {link='ErrorMsg'  },
	ALEWarningSign = {link='WarningMsg'},

	--[[ 4.4.2. coc.nvim ]]
	CocErrorHighlight   = {bg=NONE,               fg=NONE,  style={'undercurl', color='red'       }},
	CocErrorSign        = {link='ALEErrorSign'                                                     },
	CocHintHighlight    = {bg=NONE,               fg=NONE,  style={'undercurl', color='magenta'   }},
	CocHintSign         = {link='HintMsg'                                                          },
	CocInfoHighlight    = {bg=NONE,               fg=NONE,  style={'undercurl', color='pink_light'}},
	CocInfoSign         = {link='InfoMsg'                                                          },
	CocWarningHighlight = {bg=NONE,               fg=NONE,  style={'undercurl', color='orange'    }},
	CocWarningSign      = {link='ALEWarningSign'                                                   },

	--[[ 4.4.2. vim-jumpmotion / vim-easymotion ]]
	EasyMotion = {link = 'IncSearch' },
	JumpMotion = {link = 'EasyMotion'},

	--[[ 4.4.3. vim-markdown ]]
	htmlH1 = {link='markdownH1'},
	htmlH2 = {link='markdownH2'},
	htmlH3 = {link='markdownH3'},
	htmlH4 = {link='markdownH4'},
	htmlH5 = {link='markdownH5'},
	htmlH6 = {link='markdownH6'},

	--[[ 4.4.4. vim-gitgutter / vim-signify ]]
	GitGutterAdd          = {bg=NONE,  fg=green,   style=NONE},
	GitGutterChange       = {bg=NONE,  fg=yellow,  style=NONE},
	GitGutterDelete       = {bg=NONE,  fg=red,     style=NONE},
	GitGutterChangeDelete = {bg=NONE,  fg=orange,  style=NONE},

	SignifySignAdd          = {link='GitGutterAdd'         },
	SignifySignChange       = {link='GitGutterChange'      },
	SignifySignDelete       = {link='GitGutterDelete'      },
	SignifySignChangeDelete = {link='GitGutterChangeDelete'},

	--[[ 4.4.5. vim-indent-guides ]]
	IndentGuidesOdd  = {bg=gray_darker,  fg=NONE, style=NONE},
	IndentGuidesEven = {bg=gray_dark,    fg=NONE, style=NONE},

	--[[ 4.4.7. NERDTree ]]
	NERDTreeCWD        = {link='Label'           },
	NERDTreeUp         = {link='Operator'        },
	NERDTreeDir        = {link='Directory'       },
	NERDTreeDirSlash   = {link='Delimiter'       },
	NERDTreeOpenable   = {link='NERDTreeDir'     },
	NERDTreeClosable   = {link='NERDTreeOpenable'},
	NERDTreeExecFile   = {link='Function'        },
	NERDTreeLinkTarget = {link='Tag'             },
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

local terminal_ansi_colors = {
	[1]  = black,
	[2]  = red_dark,
	[3]  = green_dark,
	[4]  = orange,
	[5]  = blue,
	[6]  = magenta_dark,
	[7]  = teal,
	[8]  = gray,
	[9]  = gray_dark,
	[10] = red,
	[11] = green,
	[12] = yellow,
	[13] = turqoise,
	[14] = purple,
	[15] = cyan,
	[16] = gray_light
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

-- Change 'highlite' to the name of your colorscheme as defined in step 1.
require('highlite')(
	highlight_group_normal,
	highlight_groups,
	terminal_ansi_colors
)

EOF

" Thanks to Romain Lafourcade (https://github.com/romainl) for the original template (romainl/vim-rnb).
