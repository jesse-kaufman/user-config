local lspconfig = require("lspconfig")

lspconfig.vimls.setup({})

require("lspconfig.ui.windows").default_options.border = "single"
