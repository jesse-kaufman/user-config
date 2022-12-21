-- Put in ~/.vim/lua/lsp-config.lua
--- Configuration for LSP, formatters, and linters.
local nvim_lsp = require("lspconfig")
local saga = require('lspsaga')

-- Completion setup
local compe = require("compe")

vim.o.completeopt = "menuone,noselect"

compe.setup {
	enabled = true;
	autocomplete = true;
	throttle_time = 200;
	source_timeout = 150;
	source = {
		-- only read from lsp and lua as I find buffer, path and others noisy.
		nvim_lsp = true;
		nvim_lua = true;
	}
}

local group = vim.api.nvim_create_augroup("Line Diagnostics", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
	command = "Lspsaga show_line_diagnostics",
	group = group,
})

-- short cut methods.
local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function ()
	local col = vim.fn.col('.') - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Global function used to send <C-n> to compe
_G.tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t "<C-n>"
	elseif check_back_space() then
		return t "<Tab>"
	else
		return vim.fn['compe#complete']()
	end
end

-- Handler to attach LSP keymappings to buffers using LSP.
local on_attach = function(client, bufnr)
	-- helper methods for setting keymaps
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

	--- Mappings
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', 'gh', "<cmd>lua require('lspsaga.provider').lsp_finder()<CR>", opts)
	buf_set_keymap('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)

	-- Scroll down in popups
	buf_set_keymap('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)

	-- Navigate and preview
	buf_set_keymap('n', 'gs', "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts)
	buf_set_keymap('n', 'gd', "<cmd>lua require('lspsaga.provider').preview_definition()<CR>", opts)
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gr', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)

	-- View diagnostics
	buf_set_keymap('n', '[d', "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<CR>", opts)
	buf_set_keymap('n', ']d', "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>", opts)

	-- Autocomplete
	buf_set_keymap("i", "<C-Space>", 'compe#complete()', {noremap = true, silent = true, expr = true})
	buf_set_keymap("i", "<CR>", "compe#confirm('<CR>')", {noremap = true, silent = true, expr = true})
	buf_set_keymap("i", "<Esc>", "compe#close('<Esc>')", {noremap = true, silent = true, expr = true})
	buf_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	}
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
								"wordpress-stubs",
								"woocommerce-stubs",
								"acf-pro-stubs",
								"wordpress-globals",
								"wp-cli-stubs",
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



saga.init_lsp_saga()

-- saga.init_lsp_saga({
--		error_sign = '\u{F658}',
--		warn_sign = '\u{F071}',
--		hint_sign = '\u{F835}',
--		infor_sign = '\u{f05a}',
-- })

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
