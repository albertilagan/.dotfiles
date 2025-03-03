return {
  'karb94/neoscroll.nvim',
  opts = {},
  config = function()
    local neoscroll = require 'neoscroll'
    neoscroll.setup {
      -- Default easing function used in any animation where
      -- the `easing` argument has not been explicitly supplied
      easing = 'quadratic',
    }
    local keymap = {
      -- Use the "sine" easing function
      ['<C-u>'] = function()
        neoscroll.ctrl_u { duration = 150 }
      end,
      ['<C-d>'] = function()
        neoscroll.ctrl_d { duration = 150 }
      end,
      -- Use the "circular" easing function
      ['<C-b>'] = function()
        neoscroll.ctrl_b { duration = 150 }
      end,
      ['<C-f>'] = function()
        neoscroll.ctrl_f { duration = 150 }
      end,
      -- When no value is passed the `easing` option supplied in `setup()` is used
      ['<C-y>'] = function()
        neoscroll.scroll(-0.1, { move_cursor = false, duration = 150 })
      end,
      ['<C-e>'] = function()
        neoscroll.scroll(0.1, { move_cursor = false, duration = 150 })
      end,
    }
    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
