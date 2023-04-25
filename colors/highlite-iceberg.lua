local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'iceberg'
Highlite.generate('highlite-iceberg', Highlite.groups('default', palette), terminal_palette)
