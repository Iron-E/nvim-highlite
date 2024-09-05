local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'tomorrow'
Highlite.generate('highlite-tomorrow', Highlite.groups('default', palette), terminal_palette)
