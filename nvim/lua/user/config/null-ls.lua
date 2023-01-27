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
    -- debug = true,
    sources = {
        -- Diagnostics/Linters
        b.diagnostics.luacheck,
        b.diagnostics.eslint_d,
        b.diagnostics.cpplint,
        b.diagnostics.jsonlint,
        b.diagnostics.markdownlint,
        b.diagnostics.php,
        b.diagnostics.phpcs.with({
            command = os.getenv('HOME') .. '/.config/composer/vendor/bin/phpcs',
            extra_args = {
                '--severity=1',
            },
            debounce = require('user.src.lsp-handler').php_debounce,
        }),
        b.diagnostics.yamllint.with({
            extra_args = {
                '-c',
                os.getenv('HOME') .. '/.config/yamllint.yml',
            },
        }),
        b.diagnostics.vint,
        b.diagnostics.shellcheck,
        b.diagnostics.dotenv_linter,

        -- Hover Providers
        b.hover.printenv,

        -- Code Action Providers
        b.code_actions.shellcheck.with({
            extra_args = {
                '--shell',
                'bash',
            },
        }),
        b.code_actions.eslint_d,

        -- Formatters
        b.formatting.stylua,
        b.formatting.phpcsfixer,
        b.formatting.phpcbf.with({
            command = os.getenv('HOME')
                .. '/.config/composer/vendor/bin/phpcbf',
        }),
        b.formatting.prettierd,
        b.formatting.tidy,
        b.formatting.eslint_d,
        b.formatting.shfmt,
        b.formatting.beautysh,
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
    capabilities = capabilities,
})

M.get_ensure_installed = function()
    return M.ensure_installed
end

return M
