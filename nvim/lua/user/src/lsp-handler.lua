-- First, we declare an empty object and put auto-complete features from
-- nvim-cmp (we will set up cmp.lua later) in the LSP
local M = {}

-- protected call to get the cmp
local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
    return
end

-- is this needed?
M.get_capabilities = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    capabilities = vim.tbl_extend("keep", capabilities or {}, require("lsp-status").capabilities)
    return capabilities
end

-- Here we declare the setup function and add the modifications in signs and
-- extra configs, like virtual text, false update_in_insert, rounded borders
-- for float windows, etc.
M.setup = function()
    local config = {
        severity_sort = true,
        underline = true,
        update_in_insert = false,
        virtual_text = {
            spacing = 4,
        },
    }

    vim.diagnostic.config(config)
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- this function will attach our lsp_formatting function to every buffer.
M.on_attach = function(client, bufnr)
    -- Register client for messages and set up buffer autocommands to update
    -- the statusline and the current function.
    -- NOTE: on_attach is called with the client object, which is the "client" parameter below

    -- local lsp_status = require("lsp-status")
    -- lsp_status.on_attach(client)

    -- if client.supports_method("textDocument/formatting") then
    --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --     vim.api.nvim_create_autocmd("BufWritePre,BufEnter,BufNewFile", {
    --         group = augroup,
    --         buffer = bufnr,
    --         callback = function()
                -- Here we let the LSP prioritize null-ls formatters. Why?
                -- Normally when we install a separate formatter or linter
                -- in null-ls we want to use just them.
                --
                -- If you don't prioritize any, neovim will ask you every time
                -- you format which one you want to use.
                --
                -- vim.lsp.buf.format({
                --     filter = function(client)
                --         -- if client.name == "intelephense" then
                --         --  return false
                --         -- end
                --         return true
                --     end,
                --     bufnr = bufnr,
                -- })
            -- end,
        -- })
    -- end

    require("user.config.lsp-keymaps").setup_format_maps(bufnr)
    require("user.config.lsp-keymaps").setup_diag_maps(bufnr)
end

-- And finally, here we create a way to toggle format on save with the command
-- "LspToggleAutoFormat" and after everything, we return the M object to use it
-- in other files.
function M.enable_format_on_save()
    vim.cmd([[
    augroup format_on_save
        autocmd!
        autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
    augroup end
    ]])
    vim.notify("Enabled format on save")
end

function M.disable_format_on_save()
    if vim.fn.exists("#format_on_save") == 1 then
        vim.cmd("au! format_on_save")
    end
    vim.notify("Disabled format on save")
end

function M.toggle_format_on_save()
    if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
        M.enable_format_on_save()
    else
        M.disable_format_on_save()
    end
end

-- Toggle "format on save" once, to start with the format on.
-- M.toggle_format_on_save()

return M
