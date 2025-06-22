return {
  {
    'f-person/auto-dark-mode.nvim',
    opts = {
      set_dark_mode = function()
        vim.cmd [[colorscheme catppuccin-mocha]]
      end,
      set_light_mode = function()
        vim.cmd [[colorscheme catppuccin-latte]]
      end,
      update_interval = 3000,
      fallback = 'dark',
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        transparent_background = true,
      }
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      }
    end,
  },
  {
    'Shatur/neovim-ayu',
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require('ayu').setup {}
    end,
  },
}
