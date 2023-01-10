--
--  REQUIRED LUA FILES
--

-- Load lualine theme
require "user.themes.glx_lualine"

require "user.config.hlslens"

-- Load Mason
require "user.config.mason"
require("user.src.lsp-handler").setup()
require "user.config.null-ls"

-- Load LSP config -- must happen after Mason above
require "user.config.lsp"
require "user.config.lspsaga"

-- Load treesitter settings
require "user.config.treesitter"

-- Load cmp
require "user.config.cmp"
