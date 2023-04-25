local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'highlite'
Highlite.generate('highlite', Highlite.groups('default', palette), terminal_palette)
