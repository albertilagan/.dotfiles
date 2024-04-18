return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  ---@class CatppuccinOptions
  opts = {
    transparent_background = true,
  },
  init = function()
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    vim.cmd.colorscheme 'catppuccin'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
