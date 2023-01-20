local lspconfig = require('lspconfig')

local ensure_installed = {
    'vimls',
    'sumneko_lua',
}

local flags = require('user.src.lsp-handler').flags
-- local capabilities = require('user.src.lsp-handler').capabilities
local on_attach = require('user.src.lsp-handler').on_attach

lspconfig.vimls.setup({
    flags = flags,
    -- capabilities = capabilities,
    on_attach = on_attach,
})
require('lspconfig').sumneko_lua.setup({
    settings = {
        Lua = {
            semantic = {
                -- enable = false,
                keyword = false,
                variable = false,
            },
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
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
    flags = flags,
    -- capabilities = capabilities,
    on_attach = on_attach,
})

-- vim.lsp.set_log_level('debug')

local M = {}

M.get_ensure_installed = function()
    return ensure_installed
end

return M
