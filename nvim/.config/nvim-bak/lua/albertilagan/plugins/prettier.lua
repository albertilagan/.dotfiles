return {
  'MunifTanjim/prettier.nvim',
  config = function()
    local prettier = require 'prettier'
    prettier.setup {
      cli_options = {
        config_precedence = 'prefer-file', -- or "cli-override" or "file-override"
      },
    }
  end,
}
