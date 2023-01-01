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
		b.diagnostics.phpcs,
		b.diagnostics.luacheck,
		b.diagnostics.cpplint,
		b.diagnostics.php,
		-- b.diagnostics.styleint,

		-- Formatters
		b.formatting.stylua,
		b.formatting.phpcbf,
		b.formatting.prettier,
		b.formatting.shfmt,
		b.formatting.sqlformat,
		b.formatting.uncrustify.with({
			-- args = { "-c", "~/.config/uncrustify.cfg" },
			extra_args = {
				"-c",
				os.getenv( "HOME" ) .. "/.config/uncrustify.cfg",
				-- require("lspconfig.util").path.join(vim.loop.cwd(), "uncrustify.cfg"),
			}, -- for neovim/neovim repo
		}),
	},
	on_attach = require("user.src.lsp-handler").on_attach,
	capatilities = require("user.src.lsp-handler").get_capabilities(),
})
