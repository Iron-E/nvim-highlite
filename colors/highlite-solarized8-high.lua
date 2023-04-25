local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'solarized8-high'
Highlite.generate('highlite-solarized8-high', Highlite.groups('default', palette), terminal_palette)
