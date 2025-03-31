return {
  'stevearc/aerial.nvim',
  opts = {
    layout = {
      max_width = { 80, 0.2 },
      width = nil,
      min_width = 10,
      win_opts = {},
      default_direction = 'prefer_left',
      placement = 'window',
      resize_to_content = true,
      preserve_equality = false,
    },
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.icons',
  },
}
