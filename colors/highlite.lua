local Highlite = require 'highlite' --- @type Highlite

local palette, terminal_palette = Highlite.palette('default', vim.api.nvim_get_option 'background', true)
Highlite.generate('highlite', Highlite.groups('default', palette), terminal_palette)
