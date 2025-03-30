return {
  {
    'tpope/vim-dadbod',
    'kristijanhusak/vim-dadbod-completion',
    'kristijanhusak/vim-dadbod-ui',
  },
  {
    'xemptuous/sqlua.nvim',
    lazy = true,
    cmd = 'SQLua',
    config = function()
      require('sqlua').setup {
        load_connections_on_start = false,
      }
    end,
  },
}
