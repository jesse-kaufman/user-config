--
-- Trouble.nvim config
--

local M = {}

M.config = {
    -- Valid values are:
    --   * workspace_diagnostics
    --   * document_diagnostics
    --   * quickfix
    --   * lsp_references
    --   * loclist
    -- mode = "workspace_diagnostics",
    mode = 'document_diagnostics',

    position = 'bottom', -- position of the list can be: bottom, top, left, right
    height = 4, -- height of the trouble list when position is top or bottom
    icons = true, -- use devicons for filenames

    fold_open = '', -- icon used for open folds
    fold_closed = '', -- icon used for closed folds
    group = true, -- group results by file
    padding = false, -- add an extra new line on top of the list
    action_keys = { -- key mappings for actions in the trouble list
        --
        -- map to {} to remove a mapping, for example:
        --     close = {},
        --
        close = 'q', -- close the list
        cancel = '<esc>', -- cancel the preview and go back
        refresh = 'r', -- manually refresh
        jump = { '<cr>', '<tab>' }, -- jump to the diagnostic or open / close folds
        open_split = { '<c-x>' }, -- open buffer in new split
        open_vsplit = { '<c-v>' }, -- open buffer in new vsplit
        open_tab = { '<c-t>' }, -- open buffer in new tab
        jump_close = { 'o' }, -- jump to the diagnostic and close the list
        -- toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        -- toggle_preview = "P", -- toggle auto_preview
        -- hover = "K", -- opens a small popup with the full multiline message
        -- preview = "p", -- preview the diagnostic location
        close_folds = { 'zM', 'zm' }, -- close all folds
        open_folds = { 'zR', 'zr' }, -- open all folds
        toggle_fold = { 'zA', 'za' }, -- toggle fold of current file
        previous = 'k', -- previous item
        next = 'j', -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    -- auto_open = true, -- automatically open the list when you have diagnostics
    -- auto_close = true, -- automatically close the list when you have no diagnostics
    -- auto_preview = true, -- automatically preview the location of the diagnostic.
    -- auto_fold = false, -- automatically fold a file trouble list at creation

    -- for the given modes, automatically jump if there is only a single result
    auto_jump = { 'lsp_definitions' },
    use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
}

M.setup = function()
    require('trouble').setup(M.config)
end

M.show_trouble = function()
    require('toggle_lsp_diagnostics').turn_on_diagnostics()
    local trouble_config = require('user.config.trouble').config
    require('trouble').open({
        auto = true,
        auto_open = trouble_config.auto_open,
        auto_close = trouble_config.auto_close,
    })
end

return M
