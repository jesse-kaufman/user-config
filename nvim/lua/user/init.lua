--
--  REQUIRED LUA FILES
--

-- Load lualine theme
require('user.themes.glx_lualine')
local glx_icons = require('user.icons.glx-icons')

-- Load treesitter settings
require('user.config.treesitter')

-- Load cmp
require('user.config.cmp')

vim.filetype.add({
  extension = {
    yaml = 'yaml.jinja2',
  }
})

