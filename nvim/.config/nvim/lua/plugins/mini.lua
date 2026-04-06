return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.git').setup()
    require('mini.surround').setup {
      mappings = {
        find = 's/',
        find_left = 's?',
      },
    }
    require('mini.statusline').setup()
  end,
}
