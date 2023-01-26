--
-- CMP autocomplete setup
--

local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
    return
end

-- vim.o.completeopt = "menu,menuone,noselect"

-- Set up nvim-cmp.
local glx_icons = require('user.icons.glx-icons')

--
-- Autocomplete pairs when item selected from menu
--
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

cmp.setup({
    formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = require('lspkind').cmp_format({
            -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
            mode = 'symbol_text',
            preset = 'default', -- requires nerd-fonts font
            menu = {
                nvim_lsp = '[LSP]',
                nvim_lsp_signature_help = '[LSP_SIG]',
                ultisnips = '[US]',
                cmp_git = '[CMP_GIT]',
                buffer = glx_icons.file,
                -- cmdline = glx_icons.bash,
                -- nvim_lsp = glx_icons.gear,
                -- nvim_lsp_signature_help = glx_icons.gear,
                -- ultisnips = glx_icons.bolt,
                -- cmp_git = glx_icons.git_icon,
                -- buffer = glx_icons.file,
                -- cmdline = glx_icons.bash,
            },
            symbol_map = glx_icons.kind_icons,
        }),
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn['UltiSnips#Anon'](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<Leader><Enter>'] = cmp.mapping.complete(),
        ['<M-Esc>'] = cmp.mapping.abort(),
        -- Accept currently selected item in menu with Return.
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        -- Accept first item in menu or currently selected item with Tab.
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'buffer' },
        { name = 'path' },
    }),
    experimental = {
        ghost_text = {
            hl_group = 'CmpGhostText',
        },
    },
})

--
-- Set configuration for specific filetype.
--
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({ { name = 'cmp_git' } }, { { name = 'buffer' } }),
})

--
-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't
-- work anymore).
--
cmp.setup.cmdline('/', {
    formatting = {
        fields = { 'abbr' },
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
    },
})

--
-- Enable autocomplete in command line
--
cmp.setup.cmdline(':', {
    formatting = {
        fields = { 'abbr' },
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
        option = {
            ignore_cmds = { 'Man', '!' },
        },
    }),
})
