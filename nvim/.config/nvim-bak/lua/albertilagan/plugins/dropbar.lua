return {
  'Bekaboo/dropbar.nvim',
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  config = function()
    require('dropbar').setup {
      menu = {
        preview = false,
      },
    }
    local dropbar_api = require 'dropbar.api'
    vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
    vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
    vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
  end,
}
-- return {
--   'Bekaboo/dropbar.nvim',
--   name = 'dropbar',
--   event = { 'BufReadPost', 'BufNewFile' },
--   config = function()
--     vim.keymap.set('n', '<leader>bs', function()
--       require('dropbar.api').pick(vim.v.count ~= 0 and vim.v.count)
--     end)
--     require('dropbar').setup {
--       menu = {
--         keymaps = {
--           ['h'] = '<C-w>c',
--           ['l'] = function()
--             local menu = require('dropbar.api').get_current_dropbar_menu()
--             if not menu then
--               return
--             end
--             local cursor = vim.api.nvim_win_get_cursor(menu.win)
--             local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
--             if component then
--               menu:click_on(component, nil, 1, 'l')
--             end
--           end,
--         },
--       },
--     }
--   end,
-- }
