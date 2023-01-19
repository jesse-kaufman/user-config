-- glandix config for lualine
-- Author: glandix

-- bg color for file section
local file_bg_color = vim.g.glx_c_black
local glx_icons = require "user.icons.glx-icons"

local function starts_with(haystack, needle)
    return haystack:sub(1, #needle) == needle
end

local function rename_buffer(bufname)
    local retval = bufname

    if starts_with(bufname, "COMMIT_EDITMSG") then
        retval = bufname:gsub("COMMIT_EDITMSG", " 󱜾")
    elseif starts_with(bufname, "__committia_diff__") then
        retval = bufname:gsub("__committia_diff__", " ")
    end

    return retval
end

-- auto change color according to neovims mode
local function mode_color(is_fg, bg)
    local retval = {}
    local mode_colors = {
        -- NORMAL MODE
        n = vim.g.glx_c_ltgreen, -- Normal

        -- INSERT MODE
        i = vim.g.glx_c_red, -- Insert
        ic = vim.g.glx_c_red, -- Insert mode completion |compl-generic|
        cv = vim.g.glx_c_red, -- Vim Ex mode |gQ|
        ce = vim.g.glx_c_red, -- Normal Ex mode |Q|

        -- REPLACE MODE
        R = vim.g.glx_c_orange, -- Replace |R|
        Rx = vim.g.glx_c_orange, -- Replace mode |i_CTRL-X| completion
        Rv = vim.g.glx_c_orange, -- Virtual Replace |gR|

        -- SELECT/VISUAL MODE
        v = vim.g.glx_c_blue, -- Visual by character
        V = vim.g.glx_c_blue, -- Visual by line
        [""] = vim.g.glx_c_blue, -- Visual blockwise
        s = vim.g.glx_c_blue, -- Select by character
        S = vim.g.glx_c_blue, -- Select by line
        [""] = vim.g.glx_c_blue, -- Select blockwise

        -- WAITING ON USER INPUT
        r = vim.g.glx_c_cyan, -- Hit-enter prompt
        rm = vim.g.glx_c_cyan, -- The -- more -- prompt
        ["r?"] = vim.g.glx_c_cyan, -- A |:confirm| query of some sort
        no = vim.g.glx_c_cyan, -- Operator pending

        -- OTHER MODES
        ["!"] = vim.g.glx_c_teal, -- Shell or external command is executing
        t = vim.g.glx_c_teal, -- Terminal mode: keys go to the job
        c = vim.g.glx_c_magenta, -- Command-line editing
    }

    if is_fg == true then
        retval.fg = mode_colors[vim.fn.mode()]
        retval.gui = "bold"
        if bg then
            retval.bg = bg
        end
    else
        retval.fg = vim.g.glx_c_lualine_bg
        retval.bg = mode_colors[vim.fn.mode()]
        retval.gui = "bold"
    end

    return retval
end

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand "%:t") ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand "%:p:h"
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

-- Config
local config = {
    options = {
        globalstatus = true,
        always_divide_middle = false,
        section_separators = { left = "", right = glx_icons.separator },
        component_separators = { left = glx_icons.separator, right = glx_icons.separator },
        icons_enabled = true,
        theme = {
            -- Initial background colors
            normal = {
                a = {
                    fg = vim.g.glx_c_gray,
                    bg = vim.g.glx_c_lualine_bg,
                },
                b = {
                    fg = vim.g.glx_c_gray,
                    bg = vim.g.glx_c_lualine_bg,
                },
                c = {
                    fg = vim.g.glx_c_gray,
                    bg = vim.g.glx_c_lualine_bg,
                },
                x = {
                    fg = vim.g.glx_c_gray,
                    bg = vim.g.glx_c_lualine_bg,
                },
                y = {
                    fg = vim.g.glx_c_gray,
                    bg = vim.g.glx_c_lualine_bg,
                },
                z = {
                    fg = vim.g.glx_c_gray,
                    bg = vim.g.glx_c_lualine_bg,
                },
                -- visual = {
                --     z = {
                --         fg = vim.g.glx_c_gray,
                --         bg = vim.g.glx_c_lualine_bg,
                --     },
                -- },
            },
        },
    },
    sections = {
        --
        -- LEFT-HAND SECTIONS
        --

        -- MODE
        lualine_a = {
            {
                "mode",
                fmt = function()
                    return glx_icons.vim
                end,
                separator = { right = glx_icons.arrow_right_filled },
                color = mode_color,
                padding = { left = 3, right = 2 },
            },
        },

        -- FILE BASICS
        lualine_b = {

            -- FILENAME COMPONENT
            {
                "filename",
                cond = conditions.buffer_not_empty,
                padding = { left = 1, right = 0 },
                fmt = rename_buffer,
                color = function()
                    local is_modified = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(0), "modified")
                    local is_readonly = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(0), "readonly")
                    local bufname = vim.fn.expand "%:t"
                    if is_modified == true then
                        return { fg = vim.g.glx_c_orange, bg = file_bg_color }
                    elseif is_readonly == true then
                        return { fg = vim.g.glx_c_red, bg = file_bg_color }
                    elseif starts_with(bufname, "COMMIT_EDITMSG") then
                        return { fg = vim.g.glx_c_dkblue, bg = file_bg_color }
                    else
                        return { fg = vim.g.glx_c_magenta, bg = file_bg_color }
                    end
                end,
                file_status = true, -- Displays file status (readonly status, modified status)
                newfile_status = true, -- Display new file status (new file means no write after created)
                symbols = {
                    modified = glx_icons.smdot, -- Text to show when the file is modified.
                    readonly = glx_icons.lock, -- Text to show when the file is non-modifiable or readonly.
                    unnamed = "[No Name]", -- Text to show for unnamed buffers.
                    newfile = "[New]", -- Text to show for new created file before first writting
                },
            },

            -- FILESIZE COMPONENT
            {
                "filesize",
                fmt = function(size)
                    local bufname = vim.fn.expand "%:t"
                    if bufname == "COMMIT_EDITMSG" then
                        return ""
                    end
                    return size
                end,
                color = { bg = file_bg_color },
                padding = { left = 1, right = 0 },
                cond = conditions.hide_in_width,
            },

            {
                function()
                    return " "
                end,
                color = { bg = file_bg_color },
                padding = { left = 0, right = 0 },
                separator = { right = glx_icons.arrow_right_filled },
            },
        },

        -- DIAGNOSTICS
        lualine_c = {

            -- FILE DIAGNOSTICS
            {
                "diagnostics",
                separator = "",
                sources = { "nvim_diagnostic" },
                symbols = { error = " ", warn = " ", info = " " },
                color = { bg = vim.g.glx_c_lualine_bg },
                diagnostics_color = {
                    color_error = { fg = vim.g.glx_c_red },
                    color_warn = { fg = vim.g.glx_c_yellow },
                    color_info = { fg = vim.g.glx_c_cyan },
                },
                {
                    "%w",
                    cond = function()
                        return vim.wo.previewwindow
                    end,
                },
                {
                    "%r",
                    cond = function()
                        return vim.bo.readonly
                    end,
                },
                {
                    "%q",
                    cond = function()
                        if vim.bo.buftype == "quickfix" then
                            return ""
                        end
                    end,
                },
            },

            -- LSP NAME (only used when there is no LSP client)
            {
                function()
                    if next(vim.lsp.get_active_clients()) == nil then
                        return "No LSP"
                    end
                    return vim.lsp.get_active_clients()[1].name
                end,
                icon = glx_icons.gear,
                color = { bg = vim.g.glx_c_lualine_bg },
            },
            {
                "lsp_progress",
                display_components = {
                    -- "lsp_client_name",
                    {
                        "title",
                        "percentage",
                        "message",
                    },
                },
                timer = {
                    progress_enddelay = 500,
                    spinner = 500,
                    lsp_client_name_enddelay = 1000,
                },
                colors = {
                    percentage = vim.g.glx_c_lualine_fg,
                    message = vim.g.glx_c_gray,
                    title = vim.g.glx_c_yellow,
                    lsp_client_name = vim.g.glx_c_lualine_fg,
                    use = true,
                },
                color = { bg = vim.g.glx_c_lualine_bg },
                separators = {
                    progress = " | ",
                    percentage = { pre = "[", post = "%%]" },
                    messages = {
                        commenced = "In Progress",
                        completed = "Completed",
                    },
                    lsp_client_name = { pre = glx_icons.gear .. " ", post = "" },
                    message = {
                        pre = " - ",
                        post = "",
                    },
                },
                cond = conditions.hide_in_width,
            },
        },

        --
        -- RIGHT-HAND SECTIONS
        --

        -- SEARCH / FILE LOCATION
        lualine_x = {
            { "searchcount" },
            {
                "progress",
                color = { fg = vim.g.glx_c_lualine_fg },
            },
            {
                "location",
                color = { fg = vim.g.glx_c_lualine_fg },
            },
        },

        lualine_y = {},
        lualine_z = {},
    },
    tabline = {
        lualine_a = {
            -- empty space before first tab
            {
                function()
                    return " "
                end,
                padding = { left = 5, right = 0 },
                color = { bg = vim.g.glx_c_lualine_bg, fg = vim.g.glx_c_gray },
            },
        },
        -- {
        --     "buffers",
        --     fmt = function(bufname)
        --         return rename_buffer(bufname)
        --     end,

        --     -- color = { bg = vim.g.glx_c_lualine_dkbg },
        --     -- separator = { left = "L", right = "R" },
        --     show_filename_only = true, -- Shows shortened relative path when set to false.
        --     hide_filename_extension = false, -- Hide filename extension when set to true.
        --     show_modified_status = true, -- Shows indicator when the buffer is modified.
        --     mode = 0, -- 0: Shows buffer name
        --     -- max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
        --     filetype_names = {
        --         Trouble = " Diagnostics",
        --         TelescopePrompt = "Telescope",
        --         dashboard = "Dashboard",
        --         packer = "Packer",
        --         fzf = "FZF",
        --         alpha = "Alpha",
        --     }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

        --     buffers_color = {
        --         -- Same values as the general color option can be used here.
        --         active = mode_color,
        --         inactive = {
        --             fg = vim.g.glx_c_gray,
        --             bg = vim.g.glx_c_lualine_dkbg,
        --             gui = "none",
        --         }, -- Color for inactive buffer.
        --     },

        --     symbols = {
        --         modified = " " .. glx_icons.smdot, -- Text to show when the buffer is modified
        --         alternate_file = "⌁ ", -- Text to show to identify the alternate file
        --         directory = glx_icons.directory, -- Text to show when the buffer is a directory
        --     },
        -- },
        lualine_b = {
            {
                "tabs",
                fmt = function(name, context)
                    -- Show + if buffer is modified in tab
                    local buflist = vim.fn.tabpagebuflist(context.tabnr)
                    local winnr = vim.fn.tabpagewinnr(context.tabnr)
                    local bufnr = buflist[winnr]
                    local buftype = vim.bo.buftype
                    local mod = vim.fn.getbufvar(bufnr, "&mod")
                    local filetype = vim.bo.filetype
                    local file = vim.api.nvim_buf_get_name(bufnr)
                    local dev
                    local status, _ = pcall(require, "nvim-web-devicons")

                    if not status then
                        dev, _ = "", ""
                    elseif filetype == "TelescopePrompt" then
                        dev, _ = require("nvim-web-devicons").get_icon "telescope"
                    elseif filetype == "fugitive" then
                        dev, _ = require("nvim-web-devicons").get_icon "git"
                    elseif filetype == "vimwiki" then
                        dev, _ = require("nvim-web-devicons").get_icon "markdown"
                    elseif buftype == "terminal" then
                        dev, _ = require("nvim-web-devicons").get_icon "zsh"
                    elseif vim.fn.isdirectory(file) == 1 then
                        dev, _ = glx_icons.folder.open, nil
                        name = "Explore…"
                    else
                        dev, _ = require("nvim-web-devicons").get_icon(file, vim.fn.expand("#" .. bufnr .. ":e"))
                    end

                    if dev then
                        name = dev .. " " .. name
                    end

                    return name .. (mod == 1 and " " .. glx_icons.smdot or "")
                end,

                color = { bg = vim.g.glx_c_magenta },
                -- separator = { left = glx_icons.arrow_left_filled, right = glx_icons.arrow_right_filled },
                separator = "@",
                show_filename_only = true, -- Shows shortened relative path when set to false.
                hide_filename_extension = false, -- Hide filename extension when set to true.
                show_modified_status = true, -- Shows indicator when the buffer is modified.
                mode = 1,
                max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
                filetype_names = {
                    Trouble = " Diagnostics",
                    TelescopePrompt = "Telescope",
                    dashboard = "Dashboard",
                    packer = "Packer",
                    fzf = "FZF",
                    alpha = "Alpha",
                    netrw = "New File",
                }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

                tabs_color = {
                    -- Same values as the general color option can be used here.
                    active = function()
                        return mode_color(true, vim.g.glx_c_lualine_dkbg)
                    end,
                    inactive = {
                        fg = vim.g.glx_c_gray,
                        bg = vim.g.glx_c_lualine_bg,
                        gui = "none",
                    }, -- Color for inactive buffer.
                },
            },
        },
        lualine_z = {
            {
                "filetype",
                icons_enabled = true,
                "o:encoding",
                separator = "",
                fmt = string.upper,
                cond = conditions.hide_in_width,
                color = { fg = vim.g.glx_c_lualine_fg },
            },
            {
                "branch",
                icon = "",
                separator = "",
                fmt = string.upper,
                padding = { left = 1, right = 1 },
                color = { fg = vim.g.glx_c_lavendar },
            },
            {
                "diff",
                -- symbols = { added = ' ', modified = '柳', removed = ' ' },
                symbols = { added = " ", modified = " ", removed = " " },
                diff_color = {
                    added = { fg = vim.g.glx_c_ltgreen },
                    modified = { fg = vim.g.glx_c_orange },
                    removed = { fg = vim.g.glx_c_red },
                },
                cond = conditions.hide_in_width,
            },
        },
    },
    -- winbar = {
    --     lualine_a = {
    --         {
    --             function()
    --                 return " "
    --             end,
    --             color = mode_color,
    --         },
    --     },
    --     -- lualine_b = {},
    --     -- lualine_c = {},
    --     -- lualine_x = {},
    --     -- lualine_y = {},
    --     -- lualine_z = { 'nerdtree' }
    -- },
}

-- LOAD lualine
require("lualine").setup(config)
