--
-- nvim-treesitter config
--

require('nvim-treesitter.configs').setup({
    -- A list of parser names, or "all"
    ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'elixir',
        'fish',
        'graphql',
        'html',
        'javascript',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'php',
        'python',
        'regex',
        'ruby',
        'rust',
        'scss',
        'sql',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'yaml',
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- Keep highlighting from interfering with vim-polyglot
    highlight = {
        enable = false,
        -- Use vim-polyglot
        additional_vim_regex_highlighting = true,
    },
})
