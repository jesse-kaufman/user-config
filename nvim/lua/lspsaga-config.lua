--
-- Configure Lspsaga (handles showing LSP menus/popups)
--
require('lspsaga').init_lsp_saga({
  diagnostic_header = { " ", " ", " ", " " },
  move_in_saga = {
    prev = '<C-p>',
    next = '<C-n>'
  },
  code_action_num_shortcut = true,
  finder_icons = {
    def = '  ',
    ref = '諭 ',
    link = '  ',
  },
  code_action_lightbulb = {
    enable = true,
    enable_in_insert = true,
    cache_code_action = true,
    sign = false,
    update_time = 150,
    sign_priority = 20,
    virtual_text = true
  },
  code_action_icon = '',
})
