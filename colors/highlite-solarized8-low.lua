local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'solarized8-low'
Highlite.generate('highlite-solarized8-low', Highlite.groups('default', palette), terminal_palette)
