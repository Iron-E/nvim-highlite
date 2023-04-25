local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'molokai'
Highlite.generate('highlite-molokai', Highlite.groups('default', palette), terminal_palette)
