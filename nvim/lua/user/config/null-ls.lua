--
-- Null-ls Config
--
local null_ls = require('null-ls')

local M = {}

-- List builtins other than diagnostics here (diags are installed by Mason)
M.ensure_installed = {
    'prettier',
    -- 'stylua',
    'yamlfmt',
    -- 'cpplint',
    'luacheck',
    -- 'eslint',
    'shellcheck',
    'beautysh',
    'yamllint',
    -- 'markdownlint',
    -- 'jsonlint',
    -- 'vint',
    'dotenv_linter',
    -- 'phpcsfixer',
    -- 'sql_formatter',
    -- 'autopep8',
    -- 'uncrustify',
}

M.setup = function()
    local b = null_ls.builtins
    local on_attach = require('user.src.lsp-handler').on_attach
    local capabilities = vim.tbl_extend(
        'keep',
        require('cmp_nvim_lsp').default_capabilities(),
        require('lsp-status').capabilities
    )

    local sources = {
        -- Diagnostics/Linters
        b.diagnostics.luacheck,
        -- b.diagnostics.eslint,
        -- b.diagnostics.cpplint,
        -- b.diagnostics.jsonlint,
        -- b.diagnostics.markdownlint,
        -- b.diagnostics.php,
        b.diagnostics.yamllint.with({
            extra_args = {
                '-c',
                os.getenv('HOME') .. '/.config/yamllint.yml',
            },
        }),
        -- b.diagnostics.vint,
        b.diagnostics.shellcheck,
        b.diagnostics.dotenv_linter,

        -- Hover Providers
        b.hover.printenv,

        -- Code Action Providers
        b.code_actions.shellcheck,
        -- b.code_actions.eslint,

        -- Formatters
        -- b.formatting.stylua,
        -- b.formatting.phpcsfixer,
        -- b.formatting.phpcbf,
        -- b.formatting.phpcbf.with({
            -- command = os.getenv('HOME')
                -- .. '/.config/composer/vendor/bin/phpcbf',
        -- }),
        b.formatting.prettier,
        -- b.formatting.tidy,
        -- b.formatting.eslint,
        b.formatting.beautysh,
        -- b.formatting.sql_formatter,
        b.formatting.yamlfmt.with({
            extra_args = {
                '-conf',
                os.getenv('HOME') .. '/.config/yamlfmt.yml',
            },
        }),
        -- b.formatting.autopep8,
        -- b.formatting.uncrustify.with({
            -- extra_args = {
                -- '-c',
                -- os.getenv('HOME') .. '/.config/uncrustify.cfg',
            -- },
        -- }),
    }

    null_ls.setup({
        -- debug = true,
        sources = sources,
        flags = require('user.src.lsp-handler').flags,
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

return M
