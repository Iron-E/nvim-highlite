local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'seoul256'
Highlite.generate('highlite-seoul256', Highlite.groups('seoul256', palette), terminal_palette)
