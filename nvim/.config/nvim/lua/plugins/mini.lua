return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.git').setup()
    require('mini.surround').setup()
    require('mini.statusline').setup()
  end,
}
