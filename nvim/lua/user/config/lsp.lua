local lspconfig = require('lspconfig')

local M = {}

M.ensure_installed = {
    -- 'vimls',
    'lua_ls',
    -- 'cssmodules_ls',
    -- 'intelephense',
}

M.setup = function()
    -- vim.lsp.set_log_level('debug')

    -- Get flags, expanded capabilities, and on_attach handler for use with each server
    local flags = {
        debounce_text_changes = 250,
    }
    local on_attach = require('user.src.lsp-handler').on_attach
    local capabilities = vim.tbl_extend(
        'keep',
        require('cmp_nvim_lsp').default_capabilities(),
        require('lsp-status').capabilities
    )

    --
    -- VIM LANGUAGE SERVER
    --
    -- lspconfig.vimls.setup({
    --     flags = flags,
    --     capabilities = capabilities,
    --     on_attach = on_attach,
    -- })


    -- SQL language server
    -- lspconfig.sqlls.setup({
    --     flags = flags,
    --     capabilities = capabilities,
    --     on_attach = on_attach,
    -- })

    --
    -- CSS language server
    --
    -- lspconfig.cssmodules_ls.setup({
    --     flags = flags,
    --     capabilities = capabilities,
    --     on_attach = on_attach,
    -- })

    -- lspconfig.ccls.setup({
    --     flags = flags,
    --     capabilities = capabilities,
    --     on_attach = on_attach,
    -- })

    lspconfig.bashls.setup({
        flags = flags,
        capabilities = capabilities,
        on_attach = on_attach,
    })

    --
    -- LUA LANGUAGE SERVER
    --
    lspconfig.lua_ls.setup({
        single_file_support = true,
        settings = {
            Lua = {
                semantic = {
                    -- Don't allow LS to override our syntax highlighting
                    enable = false,
                },
                runtime = {
                    -- Tell the language server which version of Lua you're
                    -- using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files

                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
        flags = flags,
        capabilities = capabilities,
        on_attach = on_attach,
    })

end

return M
