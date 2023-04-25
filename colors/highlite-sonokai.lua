local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'sonokai'
Highlite.generate('highlite-sonokai', Highlite.groups('default', palette), terminal_palette)
