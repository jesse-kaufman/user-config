-- Put in ~/.vim/lua/lsp-config.lua
--- Configuration for LSP, formatters, and linters.
local nvim_lsp = require("lspconfig")
local saga = require('lspsaga')
-- Set up nvim-cmp.
local cmp = require'cmp'

-- Completion setup
-- local compe = require("compe")

vim.o.completeopt = "menuone,noselect"

-- compe.setup {
-- 	enabled = true;
-- 	autocomplete = true;
-- 	throttle_time = 200;
-- 	source_timeout = 150;
-- 	source = {
-- 		-- only read from lsp and lua as I find buffer, path and others noisy.
-- 		nvim_lsp = true;
-- 		nvim_lua = true;

-- 	}
-- }

-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua require('lspsaga.diagnostic').show_line_diagnostics({focus = false}]]


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

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
USER = vim.fn.expand('$USER')

local sumneko_root_path = ""
local sumneko_binary = ""

if vim.fn.has("mac") == 1 then
    sumneko_root_path = "/Users/" .. USER .. "/.config/nvim/lua-language-server"
    sumneko_binary = "/Users/" .. USER .. "/.config/nvim/lua-language-server/bin/lua-language-server"
elseif vim.fn.has("unix") == 1 then
    sumneko_root_path = "/home/" .. USER .. "/.config/nvim/lua-language-server"
    sumneko_binary = "/home/" .. USER .. "/.config/nvim/lua-language-server/bin/lua-language-server"
else
    print("Unsupported system for sumneko")
end

nvim_lsp.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
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
    on_attach = on_attach
}
-- Typescript
nvim_lsp.tsserver.setup {
	on_attach = function(client, bufnr)
		-- Disable tsserver formatting as prettier/eslint does that.
		client.resolved_capabilities.document_formatting = false
		on_attach(client, bufnr)
	end
}
-- Python
nvim_lsp.pyright.setup {
	on_attach = on_attach,
}
-- PHP
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
						};
				};
		},
		capabilities = capabilities,
		on_attach = on_attach
});

nvim_lsp.cssls.setup{
		capabilities = capabilities,
		on_attach = on_attach
}
nvim_lsp.html.setup{
		capabilities = capabilities,
		on_attach = on_attach
}
nvim_lsp.bashls.setup{
		capabilities = capabilities,
		on_attach = on_attach
}
nvim_lsp.vimls.setup{
		capabilities = capabilities,
		on_attach = on_attach
}



require('lspkind').init({
    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'default',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
})

saga.init_lsp_saga({
	diagnostic_header = { " ", " ", " ", " " },
	move_in_saga = { prev = '<C-p>',next = '<C-n>'},
	code_action_num_shortcut = true,
	finder_icons = {
		def = '  ',
		ref = '諭 ',
		link = '  ',
},

})

--- Linter setup
local filetypes = {
	typescript = "eslint",
	typescriptreact = "eslint",
	python = "flake8",
	php = {"phpcs", "psalm"},
}

local linters = {
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
	phpcs = {
		command = "vendor/bin/phpcs",
		sourceName = "phpcs",
		debounce = 300,
		rootPatterns = {"composer.lock", "vendor", ".git"},
		args = {"--report=emacs", "-s", "-"},
		offsetLine = 0,
		offsetColumn = 0,
		sourceName = "phpcs",
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
	},
	psalm = {
		command = "./vendor/bin/psalm",
		sourceName = "psalm",
		debounce = 100,
		rootPatterns = {"composer.lock", "vendor", ".git"},
		args = {"--output-format=emacs", "--no-progress"},
		offsetLine = 0,
		offsetColumn = 0,
		sourceName = "psalm",
		formatLines = 1,
		formatPattern = {
			"^[^ =]+ =(\\d+) =(\\d+) =(.*)\\s-\\s(.*)(\\r|\\n)*$",
			{
				line = 1,
				column = 2,
				message = 4,
				security = 3
			}
		},
		securities = {
			error = "error",
			warning = "warning"
		},
		requiredFiles = {"vendor/bin/psalm"}
	}
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		virtual_text = false
	}
)


nvim_lsp.diagnosticls.setup {
	on_attach = on_attach,
	filetypes = vim.tbl_keys(filetypes),
	init_options = {
		filetypes = filetypes,
		linters = linters,
	},
}



  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    },
    {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  --   capabilities = capabilities
  -- }
