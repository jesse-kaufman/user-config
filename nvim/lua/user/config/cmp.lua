--
-- CMP autocomplete setup
--

local cmp = require('cmp')

-- vim.o.completeopt = "menu,menuone,noselect"

-- Set up nvim-cmp.
local glx_icons = require('user.icons.glx-icons')

--
-- Autocomplete pairs when item selected from menu
--
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

cmp.setup({
    formatting = {
        fields = { 'abbr', 'kind', 'menu' },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- ['<Leader><Enter>'] = cmp.mapping.complete(),
        ['<M-Esc>'] = cmp.mapping.abort(),
        -- Accept currently selected item in menu with Return.
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        -- Accept first item in menu or currently selected item with Tab.
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
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
    sources = cmp.config.sources(
        { { name = 'cmp_git' } },
        { { name = 'buffer' } }
    ),
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
