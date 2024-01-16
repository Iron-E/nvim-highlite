local Fmt = require 'highlite.fmt' --- @type highlite.Fmt
local Nvim = require 'highlite.nvim' --- @type highlite.Nvim

local FMT = [[

	<key>settings</key>
	<array>
		<dict>
			<key>settings</key>
			<dict>
				<key>background</key> <string>${Normal.bg}</string>
				<key>foreground</key> <string>${Normal.fg}</string>
				<key>caret</key> <string>${Cursor.bg | Cursor.fg}</string>
				<key>block_caret</key> <string>${Cursor.bg | Cursor.fg}</string>
				<key>lineHighlight</key> <string>${CursorLine.bg | CursorLine.fg}</string>

				<key>misspelling</key> <string>${SpellBad.sp}</string>
				<key>minimapBorder</key> <string>${WinSeparator.fg | WinSeparator.bg}</string>

				<key>gutter</key> <string>${SignColumn.bg | Normal.bg}</string>
				<key>gutterForeground</key> <string>${LineNr.fg}</string>

				<key>inactiveSelection</key> <string>${VisualNOS.bg}</string>
				<key>inactiveSelectionForeground</key> <string>${VisualNOS.fg}</string>
				<key>selection</key> <string>${Visual.bg | PmenuSel.bg}</string>
				<key>selectionBorder</key> <string>${Visual.bg | PmenuSel.bg}</string>
				<key>selectionForeground</key> <string>${Visual.fg | PmenuSel.fg}</string>

				<key>findHighlight</key> <string>${IncSearch.bg | IncSearch.sp}</string>
				<key>findHighlightForeground</key> <string>${IncSearch.fg}</string>
				<key>highlight</key> <string>${Search.sp | Search.bg | Search.fg}</string>

				<key>guide</key> <string>${Whitespace.fg}</string>
				<key>activeGuide</key> <string>${Label.fg | Label.bg}</string>

				<key>bracketsForeground</key> <string>${@punctuation.bracket.sp | @punctuation.bracket.fg}</string>
				<key>bracketContentsOptions</key> <string>
					${@punctuation.bracket.underline | @punctuation.bracket.undercurl | @punctuation.bracket.underdouble | @punctuation.bracket.underdashed | @punctuation.bracket.underdotted}
				</string>

				<key>bracketsForeground</key> <string>${MatchParen.sp | MatchParen.fg}</string>
				<key>bracketsOptions</key> <string>
					${MatchParen.underline | MatchParen.undercurl | MatchParen.underdouble | MatchParen.underdashed | MatchParen.underdotted}
				</string>

				<key>tagsForeground</key> <string>${MatchParen.sp | MatchParen.fg}</string>
				<key>tagsOptions</key> <string>
					${MatchParen.underline | MatchParen.undercurl | MatchParen.underdouble | MatchParen.underdashed | MatchParen.underdotted}
				</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Line Comment</string>
			<key>scope</key> <string>comment.line, comment.block</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@comment.bg}</string>
				<key>foreground</key> <string>${@comment.fg}</string>
				<key>fontStyle</key> <string>${@comment.bold}${@comment.italic}${@comment.strikethrough}${@comment.undercurl}${@comment.underdashed}${@comment.underdotted}${@comment.underdouble}${@comment.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Doc Comment</string>
			<key>scope</key> <string>comment.block.documentation</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@comment.documentation.bg}</string>
				<key>foreground</key> <string>${@comment.documentation.fg}</string>
				<key>fontStyle</key> <string>${@comment.documentation.bold}${@comment.documentation.italic}${@comment.documentation.strikethrough}${@comment.documentation.undercurl}${@comment.documentation.underdashed}${@comment.documentation.underdotted}${@comment.documentation.underdouble}${@comment.documentation.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Comment Delimiter</string>
			<key>scope</key> <string>punctuation.definition.comment</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${SpecialComment.bg}</string>
				<key>foreground</key> <string>${SpecialComment.fg}</string>
				<key>fontStyle</key> <string>${SpecialComment.bold}${SpecialComment.italic}${SpecialComment.strikethrough}${SpecialComment.undercurl}${SpecialComment.underdashed}${SpecialComment.underdotted}${SpecialComment.underdouble}${SpecialComment.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Number</string>
			<key>scope</key> <string>constant.numeric</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@number.bg}</string>
				<key>foreground</key> <string>${@number.fg}</string>
				<key>fontStyle</key> <string>${@number.bold}${@number.italic}${@number.strikethrough}${@number.undercurl}${@number.underdashed}${@number.underdotted}${@number.underdouble}${@number.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>@floatloating Point Number</string>
			<key>scope</key> <string>constant.numeric.float</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@float.bg}</string>
				<key>foreground</key> <string>${@float.fg}</string>
				<key>fontStyle</key> <string>${@float.bold}${@float.italic}${@float.strikethrough}${@float.undercurl}${@float.underdashed}${@float.underdotted}${@float.underdouble}${@float.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Builtin Constant</string>
			<key>scope</key> <string>constant.language</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@constant.builtin.bg}</string>
				<key>foreground</key> <string>${@constant.builtin.fg}</string>
				<key>fontStyle</key> <string>${@constant.builtin.bold}${@constant.builtin.italic}${@constant.builtin.strikethrough}${@constant.builtin.undercurl}${@constant.builtin.underdashed}${@constant.builtin.underdotted}${@constant.builtin.underdouble}${@constant.builtin.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>String Escape</string>
			<key>scope</key> <string>constant.character.escape</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@string.escape.bg}</string>
				<key>foreground</key> <string>${@string.escape.fg}</string>
				<key>fontStyle</key> <string>${@string.escape.bold}${@string.escape.italic}${@string.escape.strikethrough}${@string.escape.undercurl}${@string.escape.underdashed}${@string.escape.underdotted}${@string.escape.underdouble}${@string.escape.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Misc. Constant</string>
			<key>scope</key> <string>constant.other, entity.name.constant, support.constant, variable.other.constant</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@constant.bg}</string>
				<key>foreground</key> <string>${@constant.fg}</string>
				<key>fontStyle</key> <string>${@constant.bold}${@constant.italic}${@constant.strikethrough}${@constant.undercurl}${@constant.underdashed}${@constant.underdotted}${@constant.underdouble}${@constant.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Format String</string>
			<key>scope</key> <string>constant.other.placeholder</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@string.special.bg}</string>
				<key>foreground</key> <string>${@string.special.fg}</string>
				<key>fontStyle</key> <string>${@string.special.bold}${@string.special.italic}${@string.special.strikethrough}${@string.special.undercurl}${@string.special.underdashed}${@string.special.underdotted}${@string.special.underdouble}${@string.special.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Class Name</string>
			<key>scope</key> <string>entity.name.class, support.class</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@lsp.type.class.bg}</string>
				<key>foreground</key> <string>${@lsp.type.class.fg}</string>
				<key>fontStyle</key> <string>${@lsp.type.class.bold}${@lsp.type.class.italic}${@lsp.type.class.strikethrough}${@lsp.type.class.undercurl}${@lsp.type.class.underdashed}${@lsp.type.class.underdotted}${@lsp.type.class.underdouble}${@lsp.type.class.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Struct Name</string>
			<key>scope</key> <string>entity.name.struct, support.struct</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@structure.bg}</string>
				<key>foreground</key> <string>${@structure.fg}</string>
				<key>fontStyle</key> <string>${@structure.bold}${@structure.italic}${@structure.strikethrough}${@structure.undercurl}${@structure.underdashed}${@structure.underdotted}${@structure.underdouble}${@structure.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Enums</string>
			<key>scope</key> <string>entity.name.enum, entity.name.union, support.union</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@lsp.type.enum.bg}</string>
				<key>foreground</key> <string>${@lsp.type.enum.fg}</string>
				<key>fontStyle</key> <string>${@lsp.type.enum.bold}${@lsp.type.enum.italic}${@lsp.type.enum.strikethrough}${@lsp.type.enum.undercurl}${@lsp.type.enum.underdashed}${@lsp.type.enum.underdotted}${@lsp.type.enum.underdouble}${@lsp.type.enum.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Interface Name</string>
			<key>scope</key> <string>entity.name.interface, entity.name.trait, support.interface, support.trait</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@lsp.type.enum.bg}</string>
				<key>foreground</key> <string>${@lsp.type.enum.fg}</string>
				<key>fontStyle</key> <string>${@lsp.type.enum.bold}${@lsp.type.enum.italic}${@lsp.type.enum.strikethrough}${@lsp.type.enum.undercurl}${@lsp.type.enum.underdashed}${@lsp.type.enum.underdotted}${@lsp.type.enum.underdouble}${@lsp.type.enum.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Type Name</string>
			<key>scope</key> <string>entity.name.type, support.type</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@type.bg}</string>
				<key>foreground</key> <string>${@type.fg}</string>
				<key>fontStyle</key> <string>${@type.bold}${@type.italic}${@type.strikethrough}${@type.undercurl}${@type.underdashed}${@type.underdotted}${@type.underdouble}${@type.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Function</string>
			<key>scope</key> <string>entity.name.function, support.function, variable.function</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@function.bg}</string>
				<key>foreground</key> <string>${@function.fg}</string>
				<key>fontStyle</key> <string>${@function.bold}${@function.italic}${@function.strikethrough}${@function.undercurl}${@function.underdashed}${@function.underdotted}${@function.underdouble}${@function.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Function</string>
			<key>scope</key> <string>entity.name.macro, support.macro</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@macro.bg}</string>
				<key>foreground</key> <string>${@macro.fg}</string>
				<key>fontStyle</key> <string>${@macro.bold}${@macro.italic}${@macro.strikethrough}${@macro.undercurl}${@macro.underdashed}${@macro.underdotted}${@macro.underdouble}${@macro.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Constructor</string>
			<key>scope</key> <string>entity.name.function.constructor, support.function.constructor</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@constructor.bg}</string>
				<key>foreground</key> <string>${@constructor.fg}</string>
				<key>fontStyle</key> <string>${@constructor.bold}${@constructor.italic}${@constructor.strikethrough}${@constructor.undercurl}${@constructor.underdashed}${@constructor.underdotted}${@constructor.underdouble}${@constructor.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Namespace</string>
			<key>scope</key> <string>entity.name.namespace, support.namespace</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@namespace.bg}</string>
				<key>foreground</key> <string>${@namespace.fg}</string>
				<key>fontStyle</key> <string>${@namespace.bold}${@namespace.italic}${@namespace.strikethrough}${@namespace.undercurl}${@namespace.underdashed}${@namespace.underdotted}${@namespace.underdouble}${@namespace.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Label</string>
			<key>scope</key> <string>entity.name.label, support.label</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@label.bg}</string>
				<key>foreground</key> <string>${@label.fg}</string>
				<key>fontStyle</key> <string>${@label.bold}${@label.italic}${@label.strikethrough}${@label.undercurl}${@label.underdashed}${@label.underdotted}${@label.underdouble}${@label.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Heading/Section</string>
			<key>scope</key> <string>entity.name.section, markup.heading</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@text.title.bg}</string>
				<key>foreground</key> <string>${@text.title.fg}</string>
				<key>fontStyle</key> <string>${@text.title.bold}${@text.title.italic}${@text.title.strikethrough}${@text.title.undercurl}${@text.title.underdashed}${@text.title.underdotted}${@text.title.underdouble}${@text.title.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Tag</string>
			<key>scope</key> <string>entity.name.tag, support.tag</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@tag.bg}</string>
				<key>foreground</key> <string>${@tag.fg}</string>
				<key>fontStyle</key> <string>${@tag.bold}${@tag.italic}${@tag.strikethrough}${@tag.undercurl}${@tag.underdashed}${@tag.underdotted}${@tag.underdouble}${@tag.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Tag Attribute</string>
			<key>scope</key> <string>entity.other.attribute-name</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@tag.attribute.bg}</string>
				<key>foreground</key> <string>${@tag.attribute.fg}</string>
				<key>fontStyle</key> <string>${@tag.attribute.bold}${@tag.attribute.italic}${@tag.attribute.strikethrough}${@tag.attribute.undercurl}${@tag.attribute.underdashed}${@tag.attribute.underdotted}${@tag.attribute.underdouble}${@tag.attribute.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Parse Error</string>
			<key>scope</key> <string>invalid.illegal</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@error.bg}</string>
				<key>foreground</key> <string>${@error.fg}</string>
				<key>fontStyle</key> <string>${@error.bold}${@error.italic}${@error.strikethrough}${@error.undercurl}${@error.underdashed}${@error.underdotted}${@error.underdouble}${@error.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Deprecated</string>
			<key>scope</key> <string>invalid.deprecated</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${DiagnosticDeprecated.bg}</string>
				<key>foreground</key> <string>${DiagnosticDeprecated.fg}</string>
				<key>fontStyle</key> <string>${DiagnosticDeprecated.bold}${DiagnosticDeprecated.italic}${DiagnosticDeprecated.strikethrough}${DiagnosticDeprecated.undercurl}${DiagnosticDeprecated.underdashed}${DiagnosticDeprecated.underdotted}${DiagnosticDeprecated.underdouble}${DiagnosticDeprecated.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Control Keyword</string>
			<key>scope</key> <string>keyword.control</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@repeat.bg}</string>
				<key>foreground</key> <string>${@repeat.fg}</string>
				<key>fontStyle</key> <string>${@repeat.bold}${@repeat.italic}${@repeat.strikethrough}${@repeat.undercurl}${@repeat.underdashed}${@repeat.underdotted}${@repeat.underdouble}${@repeat.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Conditional Keyword</string>
			<key>scope</key> <string>keyword.control.conditional</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@conditional.bg}</string>
				<key>foreground</key> <string>${@conditional.fg}</string>
				<key>fontStyle</key> <string>${@conditional.bold}${@conditional.italic}${@conditional.strikethrough}${@conditional.undercurl}${@conditional.underdashed}${@conditional.underdotted}${@conditional.underdouble}${@conditional.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Import Keyword</string>
			<key>scope</key> <string>keyword.control.import</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@include.bg}</string>
				<key>foreground</key> <string>${@include.fg}</string>
				<key>fontStyle</key> <string>${@include.bold}${@include.italic}${@include.strikethrough}${@include.undercurl}${@include.underdashed}${@include.underdotted}${@include.underdouble}${@include.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Special Punctuation</string>
			<key>scope</key> <string>
				markup.list.numbered,
				markup.list.unnumbered,
				markup.other,
				punctuation.definition.annotation,
				punctuation.definition.keyword,
				punctuation.definition.variable,
				punctuation.section.interpolation.begin,
				punctuation.section.interpolation.end
			</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@punctuation.special.bg}</string>
				<key>foreground</key> <string>${@punctuation.special.fg}</string>
				<key>fontStyle</key> <string>${@punctuation.special.bold}${@punctuation.special.italic}${@punctuation.special.strikethrough}${@punctuation.special.undercurl}${@punctuation.special.underdashed}${@punctuation.special.underdotted}${@punctuation.special.underdouble}${@punctuation.special.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Misc. Keyword</string>
			<key>scope</key> <string>keyword.other</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@keyword.bg}</string>
				<key>foreground</key> <string>${@keyword.fg}</string>
				<key>fontStyle</key> <string>${@keyword.bold}${@keyword.italic}${@keyword.strikethrough}${@keyword.undercurl}${@keyword.underdashed}${@keyword.underdotted}${@keyword.underdouble}${@keyword.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Operator</string>
			<key>scope</key> <string>keyword.operator</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@operator.bg}</string>
				<key>foreground</key> <string>${@operator.fg}</string>
				<key>fontStyle</key> <string>${@operator.bold}${@operator.italic}${@operator.strikethrough}${@operator.undercurl}${@operator.underdashed}${@operator.underdotted}${@operator.underdouble}${@operator.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Operator Word</string>
			<key>scope</key> <string>keyword.operator.word</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@keyword.operator.bg}</string>
				<key>foreground</key> <string>${@keyword.operator.fg}</string>
				<key>fontStyle</key> <string>${@keyword.operator.bold}${@keyword.operator.italic}${@keyword.operator.strikethrough}${@keyword.operator.undercurl}${@keyword.operator.underdashed}${@keyword.operator.underdotted}${@keyword.operator.underdouble}${@keyword.operator.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Bold</string>
			<key>scope</key> <string>markup.bold</string>
			<key>settings</key> <dict>
				<key>fontStyle</key> <string>bold</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Italic</string>
			<key>scope</key> <string>markup.italic</string>
			<key>settings</key> <dict>
				<key>fontStyle</key> <string>italic</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Underline</string>
			<key>scope</key> <string>markup.underline</string>
			<key>settings</key> <dict>
				<key>fontStyle</key> <string>underline</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Diff Added</string>
			<key>scope</key> <string>markup.inserted</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@text.diff.add.bg}</string>
				<key>foreground</key> <string>${@text.diff.add.fg}</string>
				<key>fontStyle</key> <string>${@text.diff.add.bold}${@text.diff.add.italic}${@text.diff.add.strikethrough}${@text.diff.add.undercurl}${@text.diff.add.underdashed}${@text.diff.add.underdotted}${@text.diff.add.underdouble}${@text.diff.add.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Diff Removed</string>
			<key>scope</key> <string>markup.deleted</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@text.diff.delete.bg}</string>
				<key>foreground</key> <string>${@text.diff.delete.fg}</string>
				<key>fontStyle</key> <string>${@text.diff.delete.bold}${@text.diff.delete.italic}${@text.diff.delete.strikethrough}${@text.diff.delete.undercurl}${@text.diff.delete.underdashed}${@text.diff.delete.underdotted}${@text.diff.delete.underdouble}${@text.diff.delete.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>URIs</string>
			<key>scope</key> <string>markup.underline.link</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@text.uri.bg}</string>
				<key>foreground</key> <string>${@text.uri.fg}</string>
				<key>fontStyle</key> <string>${@text.uri.bold}${@text.uri.italic}${@text.uri.strikethrough}${@text.uri.undercurl}${@text.uri.underdashed}${@text.uri.underdotted}${@text.uri.underdouble}${@text.uri.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Quote</string>
			<key>scope</key> <string>markup.quote</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@text.quote.bg}</string>
				<key>foreground</key> <string>${@text.quote.fg}</string>
				<key>fontStyle</key> <string>${@text.quote.bold}${@text.quote.italic}${@text.quote.strikethrough}${@text.quote.undercurl}${@text.quote.underdashed}${@text.quote.underdotted}${@text.quote.underdouble}${@text.quote.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Code</string>
			<key>scope</key> <string>markup.raw.inline, markup.raw.block</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@text.literal.bg}</string>
				<key>foreground</key> <string>${@text.literal.fg}</string>
				<key>fontStyle</key> <string>${@text.literal.bold}${@text.literal.italic}${@text.literal.strikethrough}${@text.literal.undercurl}${@text.literal.underdashed}${@text.literal.underdotted}${@text.literal.underdouble}${@text.literal.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Delimiter</string>
			<key>scope</key> <string>
				punctuation.accessor,
				punctuation.separator,
				punctuation.separator.continuation,
				punctuation.terminator
			</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@punctuation.delimiter.bg}</string>
				<key>foreground</key> <string>${@punctuation.delimiter.fg}</string>
				<key>fontStyle</key> <string>${@punctuation.delimiter.bold}${@punctuation.delimiter.italic}${@punctuation.delimiter.strikethrough}${@punctuation.delimiter.undercurl}${@punctuation.delimiter.underdashed}${@punctuation.delimiter.underdotted}${@punctuation.delimiter.underdouble}${@punctuation.delimiter.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Builtin Type</string>
			<key>scope</key> <string>storage.type</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@type.builtin.bg}</string>
				<key>foreground</key> <string>${@type.builtin.fg}</string>
				<key>fontStyle</key> <string>${@type.builtin.bold}${@type.builtin.italic}${@type.builtin.strikethrough}${@type.builtin.undercurl}${@type.builtin.underdashed}${@type.builtin.underdotted}${@type.builtin.underdouble}${@type.builtin.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Storage Class</string>
			<key>scope</key> <string>storage.modifier</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@storageclass.bg}</string>
				<key>foreground</key> <string>${@storageclass.fg}</string>
				<key>fontStyle</key> <string>${@storageclass.bold}${@storageclass.italic}${@storageclass.strikethrough}${@storageclass.undercurl}${@storageclass.underdashed}${@storageclass.underdotted}${@storageclass.underdouble}${@storageclass.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Function Keyword</string>
			<key>scope</key> <string>storage.type.function, keyword.declaration.function</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@keyword.function.bg}</string>
				<key>foreground</key> <string>${@keyword.function.fg}</string>
				<key>fontStyle</key> <string>${@keyword.function.bold}${@keyword.function.italic}${@keyword.function.strikethrough}${@keyword.function.undercurl}${@keyword.function.underdashed}${@keyword.function.underdotted}${@keyword.function.underdouble}${@keyword.function.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>String</string>
			<key>scope</key> <string>string.quoted.single, string.quoted.double, string.quoted.triple, string.quoted.other</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@string.bg}</string>
				<key>foreground</key> <string>${@string.fg}</string>
				<key>fontStyle</key> <string>${@string.bold}${@string.italic}${@string.strikethrough}${@string.undercurl}${@string.underdashed}${@string.underdotted}${@string.underdouble}${@string.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Braces</string>
			<key>scope</key> <string>
				punctuation.definition.generic.begin,
				punctuation.definition.generic.end,
				punctuation.definition.string.begin,
				punctuation.definition.string.end,
				punctuation.section.block.begin,
				punctuation.section.block.end,
				punctuation.section.braces.begin,
				punctuation.section.braces.end,
				punctuation.section.brackets.begin,
				punctuation.section.brackets.end,
				punctuation.section.group.begin,
				punctuation.section.group.end,
				punctuation.section.parens.begin,
				punctuation.section.parens.end
			</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@punctuation.bracket.bg}</string>
				<key>foreground</key> <string>${@punctuation.bracket.fg}</string>
				<key>fontStyle</key> <string>${@punctuation.bracket.bold}${@punctuation.bracket.italic}${@punctuation.bracket.strikethrough}${@punctuation.bracket.undercurl}${@punctuation.bracket.underdashed}${@punctuation.bracket.underdotted}${@punctuation.bracket.underdouble}${@punctuation.bracket.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>string.regexp</string>
			<key>scope</key> <string>string.regexp</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@string.regex.bg}</string>
				<key>foreground</key> <string>${@string.regex.fg}</string>
				<key>fontStyle</key> <string>${@string.regex.bold}${@string.regex.italic}${@string.regex.strikethrough}${@string.regex.undercurl}${@string.regex.underdashed}${@string.regex.underdotted}${@string.regex.underdouble}${@string.regex.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Variable</string>
			<key>scope</key> <string>variable.other</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@variable.bg}</string>
				<key>foreground</key> <string>${@variable.fg}</string>
				<key>fontStyle</key> <string>${@variable.bold}${@variable.italic}${@variable.strikethrough}${@variable.undercurl}${@variable.underdashed}${@variable.underdotted}${@variable.underdouble}${@variable.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Builtin Variable</string>
			<key>scope</key> <string>variable.language</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@variable.builtin.bg}</string>
				<key>foreground</key> <string>${@variable.builtin.fg}</string>
				<key>fontStyle</key> <string>${@variable.builtin.bold}${@variable.builtin.italic}${@variable.builtin.strikethrough}${@variable.builtin.undercurl}${@variable.builtin.underdashed}${@variable.builtin.underdotted}${@variable.builtin.underdouble}${@variable.builtin.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Parameter</string>
			<key>scope</key> <string>variable.parameter</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@parameter.bg}</string>
				<key>foreground</key> <string>${@parameter.fg}</string>
				<key>fontStyle</key> <string>${@parameter.bold}${@parameter.italic}${@parameter.strikethrough}${@parameter.undercurl}${@parameter.underdashed}${@parameter.underdotted}${@parameter.underdouble}${@parameter.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Property</string>
			<key>scope</key> <string>variable.other.member</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@field.bg}</string>
				<key>foreground</key> <string>${@field.fg}</string>
				<key>fontStyle</key> <string>${@field.bold}${@field.italic}${@field.strikethrough}${@field.undercurl}${@field.underdashed}${@field.underdotted}${@field.underdouble}${@field.underline}</string>
			</dict>
		</dict>

		<dict>
			<key>name</key> <string>Annotation</string>
			<key>scope</key> <string>variable.annotation</string>
			<key>settings</key> <dict>
				<key>background</key> <string>${@attribute.bg}</string>
				<key>foreground</key> <string>${@attribute.fg}</string>
				<key>fontStyle</key> <string>${@attribute.bold}${@attribute.italic}${@attribute.strikethrough}${@attribute.undercurl}${@attribute.underdashed}${@attribute.underdotted}${@attribute.underdouble}${@attribute.underline}</string>
			</dict>
		</dict>
	</array>
</dict>
</plist>

<!--
vim: filetype=xml
-->
]]

--- @type highlite.Fmt.string.opts
local FMT_OPTS =
{
	default =
	{
		bg = '',
		blend = '',
		bold = '',
		default = '',
		fg = '',
		italic = '',
		nocombine = '',
		reverse = '',
		sp = '',
		standout = '',
		strikethrough = '',
		undercurl = '',
		underdashed = '',
		underdotted = '',
		underdouble = '',
		underline = '',
	},

	map =
	{
		--- @param value string
		bg = function(value) return value:sub(2, -2) end,
		blend = function() return 'blend ' end,
		bold = function() return 'bold ' end,
		default = function() return 'default ' end,
		italic = function() return 'italic ' end,
		nocombine = function() return 'nocombine ' end,
		reverse = function() return 'reverse ' end,
		standout = function() return 'standout ' end,
		strikethrough = function() return 'squiggly_underline ' end, --- NOTE: Sublime Text does not support strikethrough
		undercurl = function() return 'squiggly_underline ' end,
		underdouble = function() return 'stippled_underline ' end,
		underline = function() return 'underline ' end,
	},
}

FMT_OPTS.map.fg = FMT_OPTS.map.bg
FMT_OPTS.map.sp = FMT_OPTS.map.bg

FMT_OPTS.map.underdotted = FMT_OPTS.map.underline
FMT_OPTS.map.underdotted = FMT_OPTS.map.underline

--- Create a wezterm theme out of the `palette`
--- @type highlite.export.format.module
local function export(colorscheme, opts, dir)
	if opts == nil then opts = {} end

	-- checked for backwards compatability
	if dir == nil then
		dir = vim.fn.system({'bat', '--config-dir'}):sub(1, -2) .. '/themes'
	end

	dir = vim.fs.normalize(dir)
	local filename = opts.filename or colorscheme

	local content --- @type string
	Nvim.with_colorscheme(colorscheme, function()
		content = [[<!-- Generated by https://github.com/Iron-E/nvim-highlite -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>name</key>
	<string>]] .. filename .. [[</string>]] .. Fmt.string(FMT, FMT_OPTS):gsub('\n(%s+)<key>%w+</key>%s+<string></string>', '')
	end)

	return dir .. '/' .. filename .. '.tmTheme', content, opts
end

return export
