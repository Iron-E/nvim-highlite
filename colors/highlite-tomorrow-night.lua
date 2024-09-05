local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'tomorrow-night'
Highlite.generate('highlite-tomorrow-night', Highlite.groups('default', palette), terminal_palette)
