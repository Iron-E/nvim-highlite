local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette 'seoul256-light'
Highlite.generate('highlite-seoul256-light', Highlite.groups('seoul256-light', palette), terminal_palette)
