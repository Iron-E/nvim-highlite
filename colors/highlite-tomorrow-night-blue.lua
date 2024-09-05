local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'tomorrow-night-blue'
Highlite.generate('highlite-tomorrow-night-blue', Highlite.groups('default', palette), terminal_palette)
