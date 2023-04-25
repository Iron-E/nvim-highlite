local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'gruvbox'
Highlite.generate('highlite-gruvbox', Highlite.groups('default', palette), terminal_palette)
