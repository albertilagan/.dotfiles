-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.api.nvim_create_autocmd('BufDelete', {
--   desc = "Open Dashboard when there's no active buffer left",
--   group = vim.api.nvim_create_augroup('custom-buffer', { clear = true }),
--   callback = function()
--     require('albertilagan.config.functions').close_buffer()
--   end,
-- })
