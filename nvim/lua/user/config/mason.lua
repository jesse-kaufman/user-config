--
-- Mason config
--

-- protected calls
local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
	return
end

local status_ok_2, mason_null_ls = pcall(require, "mason-null-ls")
if not status_ok_2 then
	return
end

local glx_icons = require("user.icons.glx-icons")

local mason_config = {
	ui = {
		icons = {
			-- The list icon to use for installed packages.
			package_installed = glx_icons.package_installed,
			-- The list icon to use for packages that are installing, or queued for installation.
			package_pending = glx_icons.package_pending,
			-- The list icon to use for packages that are not installed.
			package_uninstalled = glx_icons.package_uninstalled,
		},
	},
}

local mason_null_ls_config = {
	ensure_installed = {
		-- "stylua",
		-- "cssmodules_ls",
	},
	automatic_installation = true,
	automatic_setup = true,
}

-- Load Mason
mason.setup(mason_config)

-- Load Mason-null-ls
mason_null_ls.setup(mason_null_ls_config)

-- Load Mason-lspconfig
mason_lspconfig.setup({
	automatic_installation = true,
})

-- we'll need to call lspconfig to pass our server to the native neovim lspconfig.
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

-- loop through the required packages
for _, server in pairs(mason_null_ls_config.ensure_installed) do
	opts = {
		-- getting "on_attach" and capabilities from handlers
		on_attach = require("user.src.lsp-handler").on_attach,
		capabilities = require("user.src.lsp-handler").capabilities(),
	}

	-- get the server name
	server = vim.split(server, "@")[1]

	-- pass them to lspconfig
	lspconfig[server].setup(opts)
end
