local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'solarized8'
Highlite.generate('highlite-solarized8', Highlite.groups('default', palette), terminal_palette)
