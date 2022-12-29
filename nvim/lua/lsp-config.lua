--- Configuration for LSP, formatters, and linters.
local nvim_lsp = require("lspconfig")

--
-- HANDLER FUNCTION
--

-- Handler to attach LSP keymappings to buffers using LSP.
local on_attach = function(client, bufnr)
  -- helper methods for setting keymaps
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

  --- Mappings
  local opts = { noremap=true, silent=true }

  -- Lsp finder find the symbol definition implement reference
  -- if there is no implement it will hide
  -- when you use action in finder like open vsplit then you can
  -- use <C-t> to jump back
  buf_set_keymap("n", "dh", "<cmd>Lspsaga lsp_finder<CR>", opts)

  -- Code action
  -- buf_set_keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)

  -- Rename
  buf_set_keymap("n", "dr", "<cmd>Lspsaga rename<CR>", opts)

  -- Peek Definition
  -- you can edit the definition file in this flaotwindow
  -- also support open/vsplit/etc operation check definition_action_keys
  -- support tagstack C-t jump back
  buf_set_keymap("n", "dp", "<cmd>Lspsaga peek_definition<CR>", opts)

  -- Show line diagnostics
  buf_set_keymap("n", "dl", "<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics({focus = false})<CR>", opts)

  -- Show cursor diagnostics
  buf_set_keymap("n", "dc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

  -- Diagnostic jump can use `<c-o>` to jump back
  buf_set_keymap("n", "dp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  buf_set_keymap("n", "dn", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

  -- Only jump to error
  buf_set_keymap("n", "dP", "<cmd>lua require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>", opts)
  buf_set_keymap("n", "dN", "<cmd>lua require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>", opts)

  -- Outline
  buf_set_keymap("n","do", "<cmd>Lspsaga outline<CR>",opts)

  -- Hover Doc
  buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

  -- Float terminal
  -- buf_set_keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", opts)
  -- if you want to pass some cli command into a terminal you can do it like this
  -- open lazygit in lspsaga float terminal
  -- buf_set_keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", opts)
  -- close floaterm
  -- buf_set_keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], opts)
end



--
-- LANGUAGE SERVERS
--

-- CSS language server (cssmodules_ls)
nvim_lsp.cssmodules_ls.setup {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    on_attach = function (client, bufnr)
        -- avoid accepting `definitionProvider` responses from this LSP
        client.server_capabilities.definitionProvider = false
        on_attach(client, bufnr)
    end,
}

-- Python language server (pyright)
nvim_lsp.pyright.setup {
  on_attach = on_attach,
}

-- CSS language server (cssls)
nvim_lsp.cssls.setup{
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = on_attach
}

-- HTML language server (html)
nvim_lsp.html.setup{
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = on_attach
}

-- BASH language server (bashls)
nvim_lsp.bashls.setup{
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = on_attach
}

-- vimscript language server (vimls)
nvim_lsp.vimls.setup{
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = on_attach
}

-- TypeScript language server (tsserver)
nvim_lsp.tsserver.setup {
  on_attach = function(client, bufnr)
    -- Disable tsserver formatting as prettier/eslint does that.
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end
}

-- LUA language server (sumneko_lua)
nvim_lsp.sumneko_lua.setup {
  cmd = {
    vim.fn.stdpath('config') .. "/lua-language-server/bin/lua-language-server",
    "-E",
    vim.fn.stdpath('config') .. "/lua-language-server/main.lua"
  },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
      }
    }
  },
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = on_attach
}

-- PHP language server (intelephense)
nvim_lsp.intelephense.setup({
  settings = {
    intelephense = {
      stubs = {
        "bcmath",
        "bz2",
        "Core",
        "curl",
        "date",
        "dom",
        "fileinfo",
        "filter",
        "gd",
        "gettext",
        "hash",
        "iconv",
        "imap",
        "intl",
        "json",
        "libxml",
        "mbstring",
        "mcrypt",
        "mysql",
        "mysqli",
        "password",
        "pcntl",
        "pcre",
        "PDO",
        "pdo_mysql",
        "Phar",
        "readline",
        "regex",
        "session",
        "SimpleXML",
        "sockets",
        "sodium",
        "standard",
        "superglobals",
        "tokenizer",
        "xml",
        "xdebug",
        "xmlreader",
        "xmlwriter",
        "yaml",
        "zip",
        "zlib",
        "genesis-stubs",
        "polylang-stubs"
      },
      environment = {
        document_root = ".",
        exclude = {
          "**/.git/**",
          "**/.svn/**",
          "**/.hg/**",
          "**/CVS/**",
          "**/.DS_Store/**",
          "**/node_modules/**",
          "**/bower_components/**",
          "**/vendor/**/{Tests,tests}/**",
          "/var/**",
          "/framework/**",
          "**/vendor/**/{Example,example,Examples,examples}/**"
        }
      },
      files = {
        maxSize = 5000000;
      }
    }
  },
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = on_attach
});


--
-- EXTERNAL LINTERS (NVIM-LSP)
--

--- Associate external linters with filetypes for diagnosticls (nvim-lsp)
local filetypes = {
  typescript      = "eslint",
  typescriptreact = "eslint",
  python          = "flake8",
  php             = "phpcs",
}

-- Setup external linter tools for diagnosticls (nvim-lsp)
local linters = {
  -- JavaScript (eslint)
  eslint = {
    sourceName = "eslint",
    command = "./node_modules/.bin/eslint",
    rootPatterns = {".eslintrc.js", "package.json"},
    debouce = 100,
    args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
    parseJson = {
      errorsRoot = "[0].messages",
      line = "line",
      column = "column",
      endLine = "endLine",
      endColumn = "endColumn",
      message = "${message} [${ruleId}]",
      security = "severity"
    },
    securities = {[2] = "error", [1] = "warning"}
  },
  -- Python (flake8)
  flake8 = {
    command = "flake8",
    sourceName = "flake8",
    args = {"--format", "%(row)d:%(col)d:%(code)s: %(text)s", "%file"},
    formatPattern = {
      "^(\\d+):(\\d+):(\\w+):(\\w).+: (.*)$",
      {
        line = 1,
        column = 2,
        message = {"[", 3, "] ", 5},
        security = 4
      }
    },
    securities = {
      E = "error",
      W = "warning",
      F = "info",
      B = "hint",
    },
  },
  -- PHP (phpcs)
  phpcs = {
    command = "vendor/bin/phpcs",
    sourceName = "phpcs",
    debounce = 300,
    rootPatterns = {"composer.lock", "vendor", ".git"},
    args = {"--report=emacs", "-s", "-"},
    offsetLine = 0,
    offsetColumn = 0,
    formatLines = 1,
    formatPattern = {
      "^.*:(\\d+):(\\d+):\\s+(.*)\\s+-\\s+(.*)(\\r|\\n)*$",
      {
        line = 1,
        column = 2,
        message = 4,
        security = 3
      }
    },
    securities = {
      error = "error",
      warning = "warning",
    },
    requiredFiles = {"vendor/bin/phpcs"}
  }
}

-- Setup diagnosticls (nvim-lsp) for external linters
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = vim.tbl_keys(filetypes),
  init_options = {
    filetypes = filetypes,
    linters = linters,
  },
}

-- Configure diagnosticls (nvim-lsp)
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 8,
    }
  }
)
