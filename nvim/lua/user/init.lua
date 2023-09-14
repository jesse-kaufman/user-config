--
--  REQUIRED LUA FILES
--

-- Load lualine theme
require('user.themes.glx_lualine')
local glx_icons = require('user.icons.glx-icons')

local lsp_status = require('lsp-status')
-- completion_customize_lsp_label as used in completion-nvim
-- Optional: customize the kind labels used in identifying the current function.
-- g:completion_customize_lsp_label is a dict mapping from LSP symbol kind
-- to the string you want to display as a label
lsp_status.config({
    kind_labels = glx_icons.kind_icons,
    indicator_errors = glx_icons.error,
    indicator_warnings = glx_icons.warn,
    indicator_info = glx_icons.info,
    status_symbol = glx_icons.gear .. " :",
    indicator_hint = glx_icons.hint,
    indicator_ok = glx_icons.check,
    component_separator = glx_icons.separator,
    show_filename = false,
    statusline = '',
    select_symbol = function(cursor_pos, symbol)
        if symbol.valueRange then
            local value_range = {
                ['start'] = {
                    character = 0,
                    line = vim.fn.byte2line(symbol.valueRange[1]),
                },
                ['end'] = {
                    character = 0,
                    line = vim.fn.byte2line(symbol.valueRange[2]),
                },
            }

            return require('lsp-status.util').in_range(cursor_pos, value_range)
        end
    end,
})

-- Register the progress handler
lsp_status.register_progress()

-- Load Mason
require('user.config.mason')

-- Load LSP config -- must happen after Mason above
require('user.config.lsp').setup()
require('user.config.null-ls').setup()

require('user.src.lsp-handler').setup()

-- Load treesitter settings
require('user.config.treesitter')

-- Load Trouble
require('user.config.trouble').setup()

-- Load cmp
require('user.config.cmp')

require('user.config.hlslens')
require('lsp_lines').setup()

require('fidget').setup()

require('toggle_lsp_diagnostics').init(vim.diagnostic.config())

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

