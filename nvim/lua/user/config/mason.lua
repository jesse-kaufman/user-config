--
-- Mason config
--

-- protected calls
local status_ok, mason = pcall(require, 'mason')
if not status_ok then
    return
end

local status_ok_1, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status_ok_1 then
    return
end

local status_ok_2, mason_null_ls = pcall(require, 'mason-null-ls')
if not status_ok_2 then
    return
end

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
mason.setup(mason_config)

-- Setup Mason-null-ls
mason_null_ls.setup({
    ensure_installed = require('user.config.null-ls').get_ensure_installed(),
    automatic_installation = { exclude = { 'vint' } },
    automatic_setup = true,
})

-- Load Mason-lspconfig
mason_lspconfig.setup({
    ensure_installed = require('user.config.lsp').get_ensure_installed(),
    automatic_installation = true,
    automatic_setup = true,
})
