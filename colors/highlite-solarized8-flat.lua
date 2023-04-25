local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'solarized8-flat'
Highlite.generate('highlite-solarized8-flat', Highlite.groups('default', palette), terminal_palette)
