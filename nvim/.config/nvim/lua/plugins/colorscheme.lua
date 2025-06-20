return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        transparent_background = true,
      }
      -- vim.cmd 'colorscheme catppuccin-latte'
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      -- vim.cmd 'colorscheme tokyonight-day'
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        styles = {
          bold = true,
          italic = true,
          transparency = false,
        },
      }
      vim.cmd 'colorscheme rose-pine-main'
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
      -- vim.cmd 'colorscheme ayu'
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    config = function()
      require('kanagawa').setup {
        compile = true,
        transparent = true,
        colors = {
          theme = {
            all = {
              ui = {
                float = {
                  bg = 'none',
                },
                bg_gutter = 'none',
              },
            },
          },
        },
        overrides = function(colors)
          return {
            ['@markup.link.url.markdown_inline'] = { link = 'Special' }, -- (url)
            ['@markup.link.label.markdown_inline'] = { link = 'WarningMsg' }, -- [label]
            ['@markup.italic.markdown_inline'] = { link = 'Exception' }, -- *italic*
            ['@markup.raw.markdown_inline'] = { link = 'String' }, -- `code`
            ['@markup.list.markdown'] = { link = 'Function' }, -- + list
            ['@markup.quote.markdown'] = { link = 'Error' }, -- > blockcode
            ['@markup.list.checked.markdown'] = { link = 'WarningMsg' }, -- - [X] checked list item
          }
        end,
      }
      -- vim.cmd 'colorscheme kanagawa-lotus'
    end,
    build = function()
      vim.cmd 'KanagawaCompile'
    end,
  },
}
