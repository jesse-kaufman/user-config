local K = {}

K.setup_diag_maps = function(bufnr)
    local opts = { noremap = true, silent = true }

    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

    -- Lsp finder find the symbol definition implement reference
    -- if there is no implement it will hide
    -- when you use action in finder like open vsplit then you can
    -- use <C-t> to jump back
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'dh', '<cmd>Lspsaga lsp_finder<CR>', opts)

    -- Code action
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'dca', '<cmd>Lspsaga code_action<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'v', 'dca', '<cmd>Lspsaga code_action<CR>', opts)

    -- Rename
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'dr', '<cmd>Lspsaga rename<CR>', opts)

    -- Peek Definition
    -- you can edit the definition file in this flaotwindow
    -- also support open/vsplit/etc operation check definition_action_keys
    -- support tagstack C-t jump back
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'dp', '<cmd>Lspsaga peek_definition<CR>', opts)

    -- Show line diagnostics
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'dl', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)

    -- Show cursor diagnostics
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'dc', '<cmd>Lspsaga show_cursor_diagnostics<CR>', opts)

    -- local WIN_WIDTH = vim.fn.winwidth(0)
    -- local max_width = math.floor(WIN_WIDTH * 0.7)
    -- Diagnostic jump can use `<c-o>` to jump back
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "dp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'dp', "<cmd>lua require'lspsaga.diagnostic'.goto_prev()<CR>", opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        'dn',
        "<cmd>lua require'lspsaga.diagnostic'.goto_next({width = 30})<CR>",
        opts
    )

    -- Only jump to error
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        'dP',
        "<cmd>lua require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>",
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        'dN',
        "<cmd>lua require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>",
        opts
    )

    -- Outline
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'do', '<cmd>Lspsaga outline<CR>', opts)

    -- Hover Doc
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)

    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    --
    -- Float terminal
    -- vim.api.nvim_buf_set_keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", opts)
    -- if you want to pass some cli command into a terminal you can do it like this
    -- open lazygit in lspsaga float terminal
    -- vim.api.nvim_buf_set_keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", opts)
    -- close floaterm
    -- vim.api.nvim_buf_set_keymap(bufnr, "t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], opts)
end

K.setup_format_maps = function(bufnr)
    -- local opts = { noremap = true, silent = true }

    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({timeout_ms = 10000})' ]])
    -- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]] .. require('user.src.lsp-handler').php_timeout )
    -- vim.cmd('command! LspToggleAutoFormat execute \'lua require("user.src.lsp-handler").toggle_format_on_save()\'')
end

return K
