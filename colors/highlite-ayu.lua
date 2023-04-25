local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'ayu'
Highlite.generate('highlite-ayu', Highlite.groups('default', palette), terminal_palette)
