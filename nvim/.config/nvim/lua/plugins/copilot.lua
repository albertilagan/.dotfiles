return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {}
  end,
}
-- return {
--   {
--     'zbirenbaum/copilot.lua',
--     cmd = 'Copilot',
--     event = 'InsertEnter',
--     opts = {
--       suggestion = {
--         enabled = true,
--         auto_trigger = true,
--         keymap = {
--           accept = '<Tab>',
--           next = '<M-]>',
--           prev = '<M-[>',
--           dismiss = '<C-]>',
--         },
--       },
--       panel = {
--         enabled = true,
--         auto_refresh = true,
--       },
--       filetypes = {
--         ['*'] = true,
--       },
--     },
--   },
-- }
