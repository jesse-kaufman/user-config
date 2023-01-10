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

local glx_icons = require "user.icons.glx-icons"

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
-- we'll need to call lspconfig to pass our server to the native neovim
-- lspconfig.
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local function setup_server(server)
    local opts = {
        -- getting "on_attach" and capabilities from handlers
        on_attach = require("user.src.lsp-handler").on_attach,
        capabilities = require("user.src.lsp-handler").capabilities,
    }

    -- get the server name
    server = vim.split(server, "@")[1]

    -- pass them to lspconfig
    lspconfig[server].setup(opts)
end

--
-- Load Mason
--
mason.setup(mason_config)

local lspconfig_ensure_installed = require("user.config.lsp").get_ensure_installed()

-- Setup Mason-null-ls
mason_null_ls.setup {
    ensure_installed = require("user.config.null-ls").get_ensure_installed(),
    automatic_installation = true,
    automatic_setup = true,
}

-- Load Mason-lspconfig
mason_lspconfig.setup {
    ensure_installed = lspconfig_ensure_installed,
    automatic_installation = true,
    automatic_setup = true,
}

-- loop through the required lspconfig packages
for _, server in pairs(lspconfig_ensure_installed) do
    setup_server(server)
end
