-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

vim.keymap.set("n", "Y", "yg$", { silent = true })
vim.keymap.set("n", "J", "mzJ`z`", { silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })
vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })

vim.keymap.set("x", "p", '"_dP', { silent = true })
vim.keymap.set("n", "d", '"_d', { silent = true })
vim.keymap.set("v", "d", '"_d', { silent = true })
-- vim.keymap.set("x", "<leader>p", '"_dP', { silent = true })
-- vim.keymap.set("n", "<leader>d", '"_d', { silent = true })
-- vim.keymap.set("v", "<leader>d", '"_d', { silent = true })
