--
-- Mason config
--

local glx_icons = require('user.icons.glx-icons')
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

--
-- Load Mason
--
require('mason').setup(mason_config)

-- Load Mason-lspconfig
require('mason-lspconfig').setup({
    ensure_installed = require('user.config.lsp').ensure_installed,
    automatic_installation = true,
    automatic_setup = false,
})

-- Setup Mason-null-ls
require('mason-null-ls').setup({
    ensure_installed = require('user.config.null-ls').ensure_installed,
    automatic_installation = { exclude = { 'vint' } },
    automatic_setup = false,
})
