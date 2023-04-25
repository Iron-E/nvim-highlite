local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'everforest'
Highlite.generate('highlite-everforest', Highlite.groups('default', palette), terminal_palette)
