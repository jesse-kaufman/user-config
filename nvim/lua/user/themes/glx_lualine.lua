-- glandix config for lualine
-- Author: glandix

-- bg color for file section
local file_bg_color = vim.g.glx_colors_black
local glx_icons = require('user.icons.glx-icons')

-- auto change color according to neovims mode
local function mode_color()
  local mode_colors = {
    -- NORMAL MODE
    n      = vim.g.glx_colors_ltgreen,  -- Normal

    -- INSERT MODE
    i      = vim.g.glx_colors_red,      -- Insert
    ic     = vim.g.glx_colors_red,      -- Insert mode completion |compl-generic|
    cv     = vim.g.glx_colors_red,      -- Vim Ex mode |gQ|
    ce     = vim.g.glx_colors_red,      -- Normal Ex mode |Q|

    -- REPLACE MODE
    R      = vim.g.glx_colors_orange,   -- Replace |R|
    Rx     = vim.g.glx_colors_orange,   -- Replace mode |i_CTRL-X| completion
    Rv     = vim.g.glx_colors_orange,   -- Virtual Replace |gR|

    -- SELECT/VISUAL MODE
    v      = vim.g.glx_colors_blue,     -- Visual by character
    V      = vim.g.glx_colors_blue,     -- Visual by line
    [''] = vim.g.glx_colors_blue,     -- Visual blockwise
    s      = vim.g.glx_colors_blue,     -- Select by character
    S      = vim.g.glx_colors_blue,     -- Select by line
    [''] = vim.g.glx_colors_blue,     -- Select blockwise

    -- WAITING ON USER INPUT
    r      = vim.g.glx_colors_cyan,     -- Hit-enter prompt
    rm     = vim.g.glx_colors_cyan,     -- The -- more -- prompt
    ['r?'] = vim.g.glx_colors_cyan,     -- A |:confirm| query of some sort
    no     = vim.g.glx_colors_cyan,     -- Operator pending

    -- OTHER MODES
    ['!']  = vim.g.glx_colors_teal,     -- Shell or external command is executing
    t      = vim.g.glx_colors_teal,     -- Terminal mode: keys go to the job
    c      = vim.g.glx_colors_magenta,  -- Command-line editing
  }
  return { fg = vim.g.glx_colors_lualine_bg, bg = mode_colors[vim.fn.mode()] }
end

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    section_separators = { left = glx_icons.arrow_right_filled, right = glx_icons.separator },
    component_separators = { left = glx_icons.separator, right = glx_icons.separator },
    icons_enabled = true,
    theme = {
      -- Initial background colors
      normal = {
        a = {
          fg = vim.g.glx_colors_lualine_bg,
          bg = vim.g.glx_colors_ltgreen
        },
        b = {
         fg = vim.g.glx_colors_gray,
          bg = vim.g.glx_colors_lualine_bg
        },
        c = {
          fg = vim.g.glx_colors_gray,
          bg = vim.g.glx_colors_lualine_bg
        },
        x = {
          fg = vim.g.glx_colors_gray,
          bg = vim.g.glx_colors_lualine_bg,
        },
        y = {
          fg = vim.g.glx_colors_gray,
          bg = vim.g.glx_colors_lualine_bg,
        },
        z = {
          fg = vim.g.glx_colors_gray,
          bg = vim.g.glx_colors_lualine_bg,
        },
        visual = {
        z = {
          fg = vim.g.glx_colors_gray,
          bg = vim.g.glx_colors_lualine_bg,
        },
        }
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
        'mode',
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
        'filename',
        cond = conditions.buffer_not_empty,
        padding = { left = 1, right = 0 },
        color = function()
          local is_readonly = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(0), 'readonly')
          local is_modified = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(0), 'modified')

          if is_modified == true then
            return { fg = vim.g.glx_colors_orange, bg = file_bg_color }
          elseif is_readonly == true then
            return { fg = vim.g.glx_colors_red, bg = file_bg_color }
          else
            return { fg = vim.g.glx_colors_magenta, bg = file_bg_color }
          end
        end,
        file_status = true,      -- Displays file status (readonly status, modified status)
        newfile_status = true,   -- Display new file status (new file means no write after created)
        symbols = {
          modified = glx_icons.dot,      -- Text to show when the file is modified.
          readonly = glx_icons.lock,      -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
          newfile = '[New]',     -- Text to show for new created file before first writting
        },
      },

      -- FILESIZE COMPONENT
      {
        'filesize',
        color = { bg = file_bg_color },
        padding = { left = 1, right = 0 },
        cond = conditions.hide_in_width,
      },

      {
        function ()
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
        'diagnostics',
        separator = '',
        sources = { 'nvim_diagnostic', },
        symbols = { error = ' ', warn = ' ', info = ' ' },
        diagnostics_color = {
          color_error = { fg = vim.g.glx_colors_red },
          color_warn = { fg = vim.g.glx_colors_yellow },
          color_info = { fg = vim.g.glx_colors_cyan },
        },
        {
          '%w',
          cond = function()
            return vim.wo.previewwindow
          end,
        },
        {
          '%r',
          cond = function()
            return vim.bo.readonly
          end,
        },
        {
          '%q',
          cond = function()
            if vim.bo.buftype == 'quickfix' then
              return ''
            end
          end,
        },
      },

      -- LSP SERVER INFO
      {
        function()
          local msg = "No LSP"
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()

          if next(clients) == nil then
             return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = '',
        color = { fg = vim.g.glx_colors_gray }
      },
    },


    --
    -- RIGHT-HAND SECTIONS
    --

    -- SEARCH / FILE LOCATION
    lualine_x = {
      { 'searchcount' },
      {
        'progress',
        color = { fg = vim.g.glx_colors_lualine_fg }
      },
      {
        'location',
        color = { fg = vim.g.glx_colors_lualine_fg },
      },
    },

    -- FILETYPE
    lualine_y = {
      {
        'filetype',
        icons_enabled = true,
        'o:encoding', -- option component same as &encoding in viml
        fmt = string.upper, -- I'm not sure why it's upper case either ;)
        cond = conditions.hide_in_width,
        color = { fg = vim.g.glx_colors_lualine_fg },
      }
    },

    -- GIT
    lualine_z = {
      {
        'branch',
        icon = '',
        separator = '',
        padding = { left = 1, right = 1 },
        color = { fg = vim.g.glx_colors_lavendar, bg = vim.g.glx_colors_lualine_bg },
      },
      {
        'diff',
        -- symbols = { added = ' ', modified = '柳', removed = ' ' },
        symbols = { added = ' ', modified = ' ', removed = ' ' },
        diff_color =  {
          added = { fg = vim.g.glx_colors_ltgreen },
          modified = { fg = vim.g.glx_colors_orange },
          removed = { fg = vim.g.glx_colors_red },
        },
        cond = conditions.hide_in_width,
        color = { bg = vim.g.glx_colors_lualine_bg }
      },
    },
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  tabline = {
    lualine_a = {'tabs'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  -- winbar = {
  --   lualine_a = {},
  --   lualine_b = {},
  --   lualine_c = {},
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = {}
  -- }
}


-- LOAD THEME
require('lualine').setup(config)
