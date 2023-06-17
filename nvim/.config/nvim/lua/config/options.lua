-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

vim.g.mapleader = ","
opt.conceallevel = 0
-- opt.clipboard = ""
vim.api.nvim_set_keymap("n", "<esc><esc>", ":noh<cr>", { noremap = true, silent = true })
