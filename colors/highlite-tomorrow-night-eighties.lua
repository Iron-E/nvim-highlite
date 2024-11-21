local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'tomorrow-night-eighties'
Highlite.generate('highlite-tomorrow-night-eighties', Highlite.groups('default', palette), terminal_palette)
