local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'papercolor'
Highlite.generate('highlite-papercolor', Highlite.groups('default', palette), terminal_palette)
