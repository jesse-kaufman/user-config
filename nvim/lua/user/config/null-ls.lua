--
-- Null-ls Config
--
local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
    return
end

local M = {}
local b = null_ls.builtins

-- List builtins other than diagnostics here (diags are installed by Mason)
M.ensure_installed = {
    'prettierd',
    'stylua',
    'yamlfmt',
}

local on_attach = require('user.src.lsp-handler').on_attach
local capabilities = require('user.src.lsp-handler').capabilities

null_ls.setup({
    debug = true,
    sources = {
        -- Diagnostics/Linters
        b.diagnostics.luacheck.with({
            -- capabilities = capabilities,
        }),
        b.diagnostics.cpplint.with({
            -- capabilities = capabilities,
        }),
        b.diagnostics.php.with({
            -- capabilities = capabilities,
        }),
        b.diagnostics.phpcs.with({
            command = os.getenv('HOME') .. '/.composer/vendor/bin/phpcs',
            extra_args = {
                '--severity=1',
            },
            debounce = require('user.src.lsp-handler').php_debounce,
            -- capabilities = capabilities,
        }),
        b.diagnostics.yamllint.with({
            extra_args = {
                '-c',
                os.getenv('HOME') .. '/.config/yamllint.yml',
            },
            -- capabilities = capabilities,
        }),
        b.diagnostics.vint,
        b.diagnostics.shellcheck,
        b.diagnostics.dotenv_linter,

        -- Hover Providers
        b.hover.printenv,

        -- Code Action Providers
        b.code_actions.shellcheck,

        -- Formatters
        b.formatting.stylua.with({
            on_attach = on_attach,
        }),
        b.formatting.phpcbf.with({
            command = os.getenv('HOME') .. '/.composer/vendor/bin/phpcbf',
        }),
        -- b.formatting.prettierd,
        b.formatting.tidy,
        b.formatting.shfmt,
        b.formatting.sqlformat,
        b.formatting.yamlfmt.with({
            extra_args = {
                '-conf',
                os.getenv('HOME') .. '/.config/yamlfmt.yml',
            },
        }),
        b.formatting.autopep8,
        b.formatting.uncrustify.with({
            extra_args = {
                '-c',
                os.getenv('HOME') .. '/.config/uncrustify.cfg',
            },
        }),
    },
    flags = require('user.src.lsp-handler').flags,
    on_attach = on_attach,
})

M.get_ensure_installed = function()
    return M.ensure_installed
end

return M
