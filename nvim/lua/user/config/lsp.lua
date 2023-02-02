local lspconfig = require('lspconfig')

local ensure_installed = {
    'vimls',
    'sumneko_lua',
    'cssmodules_ls',
    'intelephense',
}

-- vim.lsp.set_log_level('debug')

-- Get flags, expanded capabilities, and on_attach handler for use with each
-- server
local flags = require('user.src.lsp-handler').flags
local on_attach = require('user.src.lsp-handler').on_attach
local capabilities = require('user.src.lsp-handler').capabilities

--
-- VIM LANGUAGE SERVER
--
lspconfig.vimls.setup({
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
})

--
-- CSS language server
--
lspconfig.cssmodules_ls.setup({
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
})

--
-- LUA LANGUAGE SERVER
--
lspconfig.sumneko_lua.setup({
    single_file_support = true,
    settings = {
        Lua = {
            semantic = {
                -- enable = false,
                keyword = false,
                variable = false,
            },
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
})

--
-- INTELEPHENSE (PHP) LANGUAGE SERVER
--
lspconfig.intelephense.setup({
    settings = {
        intelephense = {
            files = {
                maxSize = 5000000,
            },
            environment = {
                includePaths = {
                    os.getenv('HOME')
                        .. '/.composer/vendor/furniture-options/fo-plugin-stubs/stubs/',
                    './vendor/furniture-options/fo-plugin-stubs/stubs/',
                },
            },
            stubs = {
                'apache',
                'bcmath',
                'bz2',
                'calendar',
                'com_dotnet',
                'Core',
                'ctype',
                'curl',
                'date',
                'dba',
                'dom',
                'enchant',
                'exif',
                'FFI',
                'fileinfo',
                'filter',
                'fpm',
                'ftp',
                'gd',
                'gettext',
                'gmp',
                'hash',
                'iconv',
                'imap',
                'intl',
                'json',
                'ldap',
                'libxml',
                'mbstring',
                'meta',
                'mysqli',
                'oci8',
                'odbc',
                'openssl',
                'pcntl',
                'pcre',
                'PDO',
                'pdo_ibm',
                'pdo_mysql',
                'pdo_pgsql',
                'pdo_sqlite',
                'pgsql',
                'Phar',
                'posix',
                'pspell',
                'readline',
                'Reflection',
                'session',
                'shmop',
                'SimpleXML',
                'snmp',
                'soap',
                'sockets',
                'sodium',
                'SPL',
                'sqlite3',
                'standard',
                'superglobals',
                'sysvmsg',
                'sysvsem',
                'sysvshm',
                'tidy',
                'tokenizer',
                'xml',
                'xmlreader',
                'xmlrpc',
                'xmlwriter',
                'xsl',
                'Zend OPcache',
                'zip',
                'zlib',
                'wordpress',
                'phpunit',
            },
        },
    },
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
})

--
-- Used by Mason to get list of must-load linters/formatters/LSP
--
local M = {}
M.get_ensure_installed = function()
    return ensure_installed
end

return M
