return {
  'karb94/neoscroll.nvim',
  opts = {},
  config = function()
    local neoscroll = require 'neoscroll'
    neoscroll.setup {
      -- Default easing function used in any animation where
      -- the `easing` argument has not been explicitly supplied
      easing = 'quadratic',
      mappings = { '<C-u>', '<C-d>' },
    }
    local keymap = {
      -- Use the "sine" easing function
      ['<C-u>'] = function()
        neoscroll.ctrl_u { duration = 150 }
      end,
      ['<C-d>'] = function()
        neoscroll.ctrl_d { duration = 150 }
      end,
    }
    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
