--
--  REQUIRED LUA FILES
--

-- Load lualine theme
require('user.themes.glx_lualine')
local glx_icons = require('user.icons.glx-icons')

-- Load cmp
require('user.config.cmp')

-- Load treesitter settings
require('user.config.treesitter')

-- Load Trouble
-- require('user.config.trouble').setup()

-- Load cmp
require('user.config.cmp')

-- require('user.config.hlslens')
-- require('lsp_lines').setup()

--require('fidget').setup()

-- require('toggle_lsp_diagnostics').init(vim.diagnostic.config())

vim.fn.sign_define(
    'DiagnosticSignError',
    { texthl = 'DiagnosticSignError', text = glx_icons.error, numhl = '' }
)
vim.fn.sign_define(
    'DiagnosticSignWarn',
    { texthl = 'DiagnosticSignWarn', text = glx_icons.warn, numhl = '' }
)
vim.fn.sign_define(
    'DiagnosticSignInfo',
    { texthl = 'DiagnosticSignInfo', text = glx_icons.info, numhl = '' }
)
vim.fn.sign_define(
    'DiagnosticSignHint',
    { texthl = 'DiagnosticSignHint', text = glx_icons.hint, numhl = '' }
)


vim.filetype.add({
  extension = {
    yaml = 'yaml.jinja2',
  }
})

