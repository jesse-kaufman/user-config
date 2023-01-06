--
-- Configure Lspsaga (handles showing LSP menus/popups)
--

local glx_icons = require("user.icons.glx-icons")

require("lspsaga").init_lsp_saga({
    diagnostic_header = {
        -- glx_icons.bolt,
        -- glx_icons.warn,
        -- glx_icons.info,
        -- glx_icons.hint,
    },
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
    code_action_icon = glx_icons.bolt,
})
