-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap -- for conciseness

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
-- keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- generate codesnap on selected text (visual mode)
keymap.set(
  "v",
  "<leader>ss",
  -- ":'<,'>Silicon[!]",
  ":'<,'>Silicon ~/screenshot/output.png<CR>",
  { silent = true, desc = "Silicon (selected)" }
)
-- generate codesnap on the whole buffer (normal mode)
keymap.set("n", "<leader>ss", ":Silicon ~/screenshot/output.png<CR>", { silent = true, desc = "Silicon (buffer)" })

keymap.set("n", "Y", "yg$", { silent = true })
keymap.set("n", "J", "mzJ`z`", { silent = true })
keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })
keymap.set("n", "n", "nzzzv", { silent = true })
keymap.set("n", "N", "Nzzzv", { silent = true })

keymap.set("x", "p", '"_dP', { silent = true })
keymap.set("n", "d", '"_d', { silent = true })
keymap.set("v", "d", '"_d', { silent = true })
keymap.set("n", "x", '"_x')
keymap.set("i", "<A-bs>", "<C-w>")

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Go to left window", remap = true, silent = true })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Go to lower window", remap = true, silent = true })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Go to upper window", remap = true, silent = true })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Go to right window", remap = true, silent = true })
map("n", "<leader>rr", "<cmd>Rest run<cr>", { desc = "Run request under the cursor", remap = true, silent = true })
map("n", "<leader>zm", "<cmd>ZenMode<cr>", { desc = "Toggle ZenMode", remap = true, silent = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
