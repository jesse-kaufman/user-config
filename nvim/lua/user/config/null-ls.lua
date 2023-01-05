--
-- Null-ls Config
--
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

local b = null_ls.builtins

null_ls.setup({
    debug = true,
    sources = {
        -- Diagnostics/Linters
        b.diagnostics.luacheck,
        b.diagnostics.cpplint,
        b.diagnostics.php,
        b.diagnostics.phpcs,
        b.diagnostics.phpstan,
        b.diagnostics.yamllint,
        b.diagnostics.vint,
        b.diagnostics.shellcheck,
        b.diagnostics.editorconfig_checker.with({
            command = "editorconfig-checker",
        }),
        b.diagnostics.dotenv_linter,

        -- Hover Providers
        b.hover.printenv,

        -- Code Action Providers
        b.code_actions.shellcheck,

        -- Formatters
        b.formatting.stylua.with({
            extra_args = {
        "-c",
        os.getenv("HOME") .. '/.config/stylua.lua'}}),
        b.formatting.phpcbf,
        b.formatting.prettierd,
        b.formatting.shfmt,
        b.formatting.sqlformat,
        b.formatting.autopep8,
        b.formatting.uncrustify.with({
            extra_args = {
                "-c",
                os.getenv("HOME") .. "/.config/uncrustify.cfg",
            },
        }),
    },
    on_attach = require("user.src.lsp-handler").on_attach,
    capabilities = require("user.src.lsp-handler").get_capabilities(),
})
