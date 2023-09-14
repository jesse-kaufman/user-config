-- First, we declare an empty object and put auto-complete features from
-- nvim-cmp (we will set up cmp.lua later) in the LSP
local M = {}

M.default_debounce = 250
M.php_debounce = M.default_debounce * 4

M.flags = {
    debounce_text_changes = M.default_debounce,
}

-- Here we declare the setup function and add the modifications in signs and
-- extra configs, like virtual text, false update_in_insert, rounded borders
-- for float windows, etc.
M.setup = function()
    vim.diagnostic.config({
        severity_sort = true,
        underline = true,
        update_in_insert = false,
        source = true,
        virtual_lines = true,
        virtual_text = false,
    })
end

M.on_attach = function(client, bufnr)
    require('lsp-status').on_attach(client)

    vim.diagnostic.config({
        severity_sort = true,
        underline = true,
        update_in_insert = false,
        source = true,
        virtual_lines = true,
        virtual_text = false,
    })

    if client.supports_method('textDocument/formatting') then
        if client.name == 'lua_ls' then
            -- Disable lua_ls formatting so stylua can handle it
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        elseif vim.bo.filetype == "yaml" then
            -- Disable yaml formatting so ansible-vim can handle it
            -- client.server_capabilities.semanticTokensProvider = nil
        elseif client.name == 'intelephense' then
        -- Disable intelephense formatting so PHPCBF can handle it
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end
    end

    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup('lsp_document_highlight', {})
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = 'lsp_document_highlight',
            buffer = 0,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            group = 'lsp_document_highlight',
            buffer = 0,
            callback = vim.lsp.buf.clear_references,
        })
    end

    require('user.config.lsp-keymaps').setup_format_maps(bufnr)
    require('user.config.lsp-keymaps').setup_diag_maps(bufnr)
end

-- And finally, here we create a way to toggle format on save with the command
-- "LspToggleAutoFormat" and after everything, we return the M object to use it
-- in other files.
-- function M.enable_format_on_save()
--     vim.cmd([[
--     augroup format_on_save
--         autocmd!
--         autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
--     augroup end
--     ]])
--     vim.notify('Enabled format on save')
-- end

-- function M.disable_format_on_save()
--     if vim.fn.exists('#format_on_save') == 1 then
--         vim.cmd('au! format_on_save')
--     end
--     vim.notify('Disabled format on save')
-- end

-- function M.toggle_format_on_save()
--     if vim.fn.exists('#format_on_save#BufWritePre') == 0 then
--         M.enable_format_on_save()
--     else
--         M.disable_format_on_save()
--     end
-- end

-- Toggle "format on save" once, to start with the format on.
-- M.toggle_format_on_save()

return M
