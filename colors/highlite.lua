local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'highlite'
Highlite.generate('highlite', Highlite.groups('highlite', palette), terminal_palette)
