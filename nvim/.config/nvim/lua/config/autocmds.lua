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
--     require('config.functions').close_buffer()
--   end,
-- })

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { 'aerospace.toml' },
  command = '!aerospace reload-config',
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { 'config.fish' },
  command = '!source ~/.config/fish/config.fish',
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { 'tmux.conf' },
  command = '!tmux source ~/.config/tmux/tmux.conf',
})

vim.api.nvim_create_autocmd('bufwritepost', {
  pattern = { '*/ghostty/config' },
  command = '!osascript -e \'tell application "System Events" to keystroke "<" using {command down, shift down}\'',
  -- command = '!ghostty +reload-config ~/.config/ghostty/config',
})
