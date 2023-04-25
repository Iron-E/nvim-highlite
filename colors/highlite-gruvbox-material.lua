local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'gruvbox-material'
Highlite.generate('highlite-gruvbox-material', Highlite.groups('default', palette), terminal_palette)
