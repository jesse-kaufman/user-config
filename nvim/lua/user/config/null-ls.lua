--
-- Null-ls Config
--
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

local b = null_ls.builtins

-- List builtins other than diagnostics here (diags are installed by Mason)
local ensure_installed = {
    "prettierd",
    "stylua",
    "yamlfmt",
}

null_ls.setup {
    debug = true,
    sources = {
        -- Diagnostics/Linters
        b.diagnostics.luacheck,
        b.diagnostics.cpplint,
        b.diagnostics.php,
        b.diagnostics.phpcs,
        b.diagnostics.phpstan.with{
            extra_args = {
                "--memory-limit",
                "512M",
            }
        },
        b.diagnostics.yamllint.with {
            extra_args = {
                "-c",
                os.getenv "HOME" .. "/.config/yamlfmt.yaml",
            }
        },
        b.diagnostics.vint,
        b.diagnostics.shellcheck,
        b.diagnostics.editorconfig_checker.with {
            command = "editorconfig-checker",
            extra_args = {
                "-ignore-defaults",
            },
        },
        b.diagnostics.dotenv_linter,

        -- Hover Providers
        b.hover.printenv,

        -- Code Action Providers
        b.code_actions.shellcheck,

        -- Formatters
        b.formatting.stylua,
        b.formatting.phpcbf,
        b.formatting.prettierd,
        b.formatting.tidy,
        b.formatting.shfmt,
        b.formatting.sqlformat,
        -- b.formatting.yamlfmt,
        b.formatting.autopep8,
        b.formatting.uncrustify.with {
            extra_args = {
                "-c",
                os.getenv "HOME" .. "/.config/uncrustify.cfg",
            },
        },
    },
    on_attach = require("user.src.lsp-handler").on_attach,
    capabilities = require("user.src.lsp-handler").get_capabilities(),
}

if vim.bo.filetype ~= "log" then
    null_ls.disable "editorconfig"
end

if vim.fn.line "$" >= 1000 then
    null_ls.disable "phpstan"
end


local M = {}

M.get_ensure_installed = function()
    return ensure_installed
end

return M
