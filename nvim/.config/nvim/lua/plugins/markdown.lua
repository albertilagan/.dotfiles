return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      render_modes = { 'n', 'c', 't' },
      completions = { blink = { enabled = true } },
      heading = {
        width = 'block',
        left_pad = 1,
        right_pad = 1,
      },
      code = {
        render_modes = true,
        style = 'full',
        language_pad = 2,
        language_icon = false,
        language_name = true,
        disable_background = false,
        width = 'block',
        left_pad = 2,
        right_pad = 2,
        min_width = 120,
        border = 'thin',
        above = '▀',
        below = '▀',
      },
    },
  },
}
