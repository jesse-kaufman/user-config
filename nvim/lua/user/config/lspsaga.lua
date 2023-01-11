--
-- Configure Lspsaga (handles showing LSP menus/popups)
--

local glx_icons = require "user.icons.glx-icons"

require("lspsaga").init_lsp_saga {
    move_in_saga = {
        prev = "<C-p>",
        next = "<C-n>",
    },
    code_action_num_shortcut = true,
    finder_icons = {
        def = "  ",
        ref = "諭 ",
        link = "  ",
    },
    code_action_lightbulb = {
        enable = true,
        enable_in_insert = true,
        cache_code_action = true,
        sign = false,
        update_time = 150,
        virtual_text = true,
    },
    show_outline = {
        win_position = "right",
        win_with = "",
        win_width = 30,
        auto_enter = false,
        auto_preview = true,
        virt_text = "┃",
        jump_key = "o",
        auto_refresh = true,
    },
    hover_action_quit = "<Esc>",
    code_action_icon = glx_icons.bolt,
    preview_lines_above = 2,
    max_preview_lines = 15,
    code_action_keys = {
        quit = "<Esc>",
        exec = "<CR>",
    },
    finder_request_timeout = 1500,
}
