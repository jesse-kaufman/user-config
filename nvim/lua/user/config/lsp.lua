local lspconfig = require('lspconfig')

lspconfig.vimls.setup({})
lspconfig.phpactor.setup({})
lspconfig.intelephense.setup({
    settings = {
        intelephense = {
            files = {
                maxSize = 5000000,
            },
            format = {
                enable = false,
            },
        },
    },
    capabilities = require('user.src.lsp-handler').get_capabilities(),
    on_attach = require('user.src.lsp-handler').on_attach,
})
vim.lsp.set_log_level('debug')

require('lspconfig.ui.windows').default_options.border = 'single'

local ensure_installed = {
    'vimls',
}

local M = {}

M.get_ensure_installed = function()
    return ensure_installed
end

return M
