-- Eviline config for lualine
-- Author: glandix
local lualine = require('lualine')

local function mode_color()
  -- auto change color according to neovims mode
  local mode_colors = {
    n      = vim.g.glx_colors_ltgreen,  -- Normal
    no     = vim.g.glx_colors_yellow,   -- Operator pending
    i      = vim.g.glx_colors_red,      -- Insert
    ic     = vim.g.glx_colors_red,      -- Insert mode completion |compl-generic|
    cv     = vim.g.glx_colors_red,      -- Vim Ex mode |gQ|
    ce     = vim.g.glx_colors_red,      -- Normal Ex mode |Q|
    v      = vim.g.glx_colors_blue,     -- Visual by character
    V      = vim.g.glx_colors_blue,     -- Visual by line
    [''] = vim.g.glx_colors_blue,     -- Visual blockwise
    s      = vim.g.glx_colors_dkorange, -- Select by character
    S      = vim.g.glx_colors_dkorange, -- Select by line
    [''] = vim.g.glx_colors_dkorange, -- Select blockwise
    R      = vim.g.glx_colors_orange,   -- Replace |R|
    Rx     = vim.g.glx_colors_orange,   -- Replace mode |i_CTRL-X| completion
    Rv     = vim.g.glx_colors_orange,   -- Virtual Replace |gR|
    r      = vim.g.glx_colors_cyan,     -- Hit-enter prompt
    rm     = vim.g.glx_colors_cyan,     -- The -- more -- prompt
    ['r?'] = vim.g.glx_colors_cyan,     -- A |:confirm| query of some sort
    ['!']  = vim.g.glx_colors_cyan,     -- Shell or external command is executing
    t      = vim.g.glx_colors_cyan,     -- Terminal mode: keys go to the job
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
    -- Disable sections and component separators
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    icons_enabled = true,
    theme = {
      -- Initial background colors
      normal = {
        a = { bg = vim.g.glx_colors_ltgreen },
        b = { bg = vim.g.glx_colors_lualine_bg },
        c = { bg = vim.g.glx_colors_lualine_bg },
        x = { bg = vim.g.glx_colors_lualine_bg },
        y = { bg = vim.g.glx_colors_lualine_bg },
        z = { bg = vim.g.glx_colors_lualine_bg }
      },
    },
  },
  sections = {
    -- First left section
    lualine_a = {
      -- mode component
      {
        'mode',
        fmt = function()
          return ''
        end,
        separator = { right = '' },
        color = mode_color,
        padding = { left = 3, right = 2 },
      },
    },

    -- Second left section
    lualine_b = {
      -- filename component
      {
        'filename',
        cond = conditions.buffer_not_empty,
        separator = { left = '' },
        color = function()
          local is_readonly = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(0), 'readonly')
          local is_modified = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(0), 'modified')

          if is_modified == true then
            return { fg = vim.g.glx_colors_orange }
          elseif is_readonly == true then
            return { fg = vim.g.glx_colors_red }
          else
            return { fg = vim.g.glx_colors_magenta }
          end
        end,
        file_status = true,      -- Displays file status (readonly status, modified status)
        newfile_status = true,   -- Display new file status (new file means no write after created)
        symbols = {
          modified = '',      -- Text to show when the file is modified.
          readonly = '',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
          newfile = '[New]',     -- Text to show for new created file before first writting
        },
      },

      -- filesize component
      {
        'filesize',
        color = { fg = vim.g.glx_colors_ltgray },
        padding = { left = 0, right = 1 },
        cond = conditions.hide_in_width,
      },

      -- diagnostics
      {
        'diagnostics',
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
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
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

-- Inserts a component in sections.lualine_c at left section
local function ins_section_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in sections.lualine_x ot right section
local function ins_section_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_section_left {
  -- Lsp server name .
  function()
    local msg = 'none'
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
  icon = ' LSP:',
  color = { fg = '#525252' },
}


-- Add components to right sections
ins_section_right { 'location' }

ins_section_right { 'progress', color = { fg = vim.g.glx_colors_lualine_fg } }

-- ins_section_right {
--   'o:encoding', -- option component same as &encoding in viml
--   fmt = string.upper, -- I'm not sure why it's upper case either ;)
--   cond = conditions.hide_in_width,
--   color = { fg = vim.g.glx_colors_green },
-- }

ins_section_right {
  'filetype',
  icons_enabled = true,
  cond = conditions.hide_in_width,
}

ins_section_right {
  'branch',
  icon = '',
  color = { fg = vim.g.glx_colors_lavendar },
}

ins_section_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳', removed = ' ' },
  -- symbols = { added = ' ', modified = ' ', removed = ' ' },
  diff_color = {
    added = { fg = vim.g.glx_colors_ltgreen },
    modified = { fg = vim.g.glx_colors_orange },
    removed = { fg = vim.g.glx_colors_red },
  },
  cond = conditions.hide_in_width,
}

--
-- Now, setup tabline components
--


-- Now don't forget to initialize lualine
lualine.setup(config)
