-- Formatters
-- Formatting can be run via :Format
local formatter = require('formatter')

local eslint_fmt = {
  function()
    return {
      exe = "./node_modules/.bin/eslint",
      args = {"--fix", "--stdin-filename", vim.api.nvim_buf_get_name(0)},
      stdin = false,
    }
  end
}

formatter.setup {
  logging = true,
  filetype = {
    typescript = eslint_fmt,
    typescriptreact = eslint_fmt,
    javascript = eslint_fmt,
    javascriptreact = eslint_fmt,
    python = {
      function ()
        return {
          exe = '~/.pyenv/shims/black',
          args = {"-"},
          stdin = true,
        }
      end,
      function ()
        return {
          exe = '~/.pyenv/shims/isort',
          args = {"-"},
          stdin = true,
        }
      end
    },
    php = {
      function ()
        return {
          exe = './vendor/bin/phpcbf',
          args = {'--stdin-path=' .. vim.api.nvim_buf_get_name(0), '-'},
          stdin = true,
          ignore_exitcode = true,
        }
      end,
      function ()
        return {
          exe = './vendor/bin/php-cs-fixer',
          args = {
            '--using-cache=no',
            '--no-interaction',
            'fix'
          },
          stdin = false,
        }
      end
    }
  }
}
