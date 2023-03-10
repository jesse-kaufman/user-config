--
-- Configure Lspsaga (handles showing LSP menus/popups)
--

local glx_icons = require('user.icons.glx-icons')

require("lsp-colors").setup({
  -- Error = vim.g.glx_c_red,
  -- Warning = vim.g.glx_c_yellow,
  -- Information = vim.g.glx_c_lualine_fg,
  -- Hint = vim.g.glx_c_gray
})

require('lspsaga').setup({
    move_in_saga = {
        prev = '<C-b>',
        next = '<C-f>',
    },
    code_action_num_shortcut = true,
    -- finder_icons = {
    --     def = "  ",
    --     ref = "諭 ",
    --     link = "  ",
    -- },
    code_action_lightbulb = {
        enable = true,
        enable_in_insert = true,
        cache_code_action = true,
        sign = false,
        update_time = 150,
        virtual_text = true,
    },
    show_outline = {
        -- win_position = "right",
        -- win_with = "",
        -- win_width = 30,
        auto_enter = false,
        auto_preview = true,
        -- virt_text = "┃",
        -- jump_key = "o",
        -- auto_refresh = true,
    },
    hover_action_quit = '<Esc>',
    code_action_icon = glx_icons.bolt,
    -- preview_lines_above = 2,
    -- max_preview_lines = 15,
    code_action_keys = {
        quit = '<Esc>',
        exec = '<CR>',
    },
    symbol_in_winbar = {
        enable = false,
        -- separator = " ",
        -- hide_keyword = true,
        -- show_file = true,
        -- folder_level = 2,
        -- respect_root = false,
        -- color_mode = false,
    },
    diagnostic = {
        show_code_action = false,
        show_source = true,
        jump_num_shortcut = true,
        keys = {
            exec_action = 'o',
            quit = '<Esc>',
            go_action = 'g',
        },
    },
    ui = {
        -- currently only round theme
        theme = 'round',
        title = true,
        -- border type can be single,double,rounded,solid,shadow.
        border = 'rounded',
        -- winblend = 50,
        -- expand = "",
        -- collapse = "",
        -- preview = " ",
        code_action = glx_icons.bolt,
        diagnostic = ' ',
        -- incoming = " ",
        -- outgoing = " ",
        colors = {
            --float window normal background color
            normal_bg = 'none',
            --title background color
            title_bg = vim.g.glx_c_lualine_fg,
            fg = vim.g.glx_c_lualine_fg,
            red = vim.g.glx_c_red,
            magenta = vim.g.glx_c_magenta,
            orange = vim.g.glx_c_orange,
            yellow = vim.g.glx_c_yellow,
            green = vim.g.glx_c_green,
            cyan = vim.g.glx_c_cyan,
            blue = vim.g.glx_c_blue,
            purple = vim.g.glx_c_purple,
            white = vim.g.glx_c_ltgray,
            black = vim.g.glx_c_black,
        },
        kind = {
            File = { '', vim.g.glx_c_white },
            Module = { ' ', vim.g.glx_c_blue },
            Namespace = { ' ', vim.g.glx_c_orange },
            Package = { ' ', vim.g.glx_c_purple },
            Class = { ' ', vim.g.glx_c_purple },
            Method = { ' ', vim.g.glx_c_purple },
            Property = {
                glx_icons.kind_icons.Property .. ' ',
                vim.g.glx_c_cyan,
            },
            Field = { ' ', vim.g.glx_c_yellow },
            Constructor = { ' ', vim.g.glx_c_blue },
            Enum = { '了', vim.g.glx_c_green },
            Interface = { ' ', vim.g.glx_c_orange },
            Function = { ' ', vim.g.glx_c_purple },
            Variable = { glx_icons.kind_icons.Variable, vim.g.glx_c_cyan },
            Constant = { ' ', vim.g.glx_c_cyan },
            String = { ' ', vim.g.glx_c_green },
            Number = { ' ', vim.g.glx_c_green },
            Boolean = { ' ', vim.g.glx_c_orange },
            Array = { ' ', vim.g.glx_c_blue },
            Object = { ' ', vim.g.glx_c_orange },
            Key = { ' ', vim.g.glx_c_red },
            Null = { ' ', vim.g.glx_c_red },
            EnumMember = { ' ', vim.g.glx_c_green },
            Struct = { ' ', vim.g.glx_c_purple },
            Event = { ' ', vim.g.glx_c_purple },
            Operator = { ' ', vim.g.glx_c_green },
            TypeParameter = { ' ', vim.g.glx_c_green },
            -- -- ccls
            TypeAlias = { ' ', vim.g.glx_c_green },
            Parameter = { ' ', vim.g.glx_c_blue },
            StaticMethod = { 'ﴂ ', vim.g.glx_c_orange },
            Macro = { ' ', vim.g.glx_c_red },
            -- -- for completion sb microsoft!!!
            Text = { ' ', vim.g.glx_c_green },
            Snippet = { ' ', vim.g.glx_c_blue },
            Folder = { ' ', vim.g.glx_c_yellow },
            Unit = { ' ', vim.g.glx_c_cyan },
            Value = { ' ', vim.g.glx_c_blue },
        },
    },
    -- finder_request_timeout = 1500,
})
