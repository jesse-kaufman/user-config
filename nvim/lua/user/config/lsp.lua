local lspconfig = require('lspconfig')

local ensure_installed = {
    'vimls',
}

lspconfig.vimls.setup({
    flags = require('user.src.lsp-handler').flags,
    capabilities = require('user.src.lsp-handler').capabilities,
    on_attach = require('user.src.lsp-handler').on_attach,
})
-- lspconfig.phpactor.setup({})

lspconfig.intelephense.setup({
    settings = {
        intelephense = {
            files = {
                maxSize = 5000000,
            },
        },
    },
    flags = require('user.src.lsp-handler').lsp_flags,
    capabilities = require('user.src.lsp-handler').capabilities,
    on_attach = require('user.src.lsp-handler').on_attach,
})
vim.lsp.set_log_level('debug')

local M = {}

M.get_ensure_installed = function()
    return ensure_installed
end

return M
