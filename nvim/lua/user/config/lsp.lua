local lspconfig = require("lspconfig")

lspconfig.vimls.setup({})

require("lspconfig.ui.windows").default_options.border = "single"

local ensure_installed = {
    "vimls",
}

local M = {}

M.get_ensure_installed = function()
    return ensure_installed
end

return M
