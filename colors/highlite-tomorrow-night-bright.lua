local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'tomorrow-night-bright'
Highlite.generate('highlite-tomorrow-night-bright', Highlite.groups('default', palette), terminal_palette)
