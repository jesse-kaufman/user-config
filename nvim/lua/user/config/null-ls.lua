--
-- Null-ls Config
--
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local b = null_ls.builtins

null_ls.setup({
	-- debug = true,
	sources = {
		b.diagnostics.phpcs,
		b.diagnostics.luacheck,
		-- b.diagnostics.styleint,
		b.diagnostics.php,
		b.formatting.stylua,
		b.formatting.phpcbf,
		b.formatting.prettier,
		b.formatting.shfmt,
		b.formatting.sqlformat,
		b.diagnostics.cpplint,
	},
	on_attach = require('user.src.lsp-handler').on_attach,
	capatilities = require('user.src.lsp-handler').get_capabilities(),
})

