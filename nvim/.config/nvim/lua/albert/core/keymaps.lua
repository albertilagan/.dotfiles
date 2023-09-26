-- set leader key to space
vim.g.mapleader = ","

local keymap = vim.keymap -- for conciseness

local function map(mode, lhs, rhs, opts)
  -- local keys = require("lazy.core.handler").handlers.keys
  -- ---@cast keys LazyKeysHandler
  -- -- do not create the keymap if a lazy keys handler exists
  -- if not keys.active[keys.parse({ lhs, mode = mode }).id] then
  --   opts = opts or {}
  --   opts.silent = opts.silent ~= false
  --   if opts.remap and not vim.g.vscode then
  --     opts.remap = nil
  --   end
  --   vim.keymap.set(mode, lhs, rhs, opts)
  -- end
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

keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map("n", "<leader>wc", "<C-w>c", { desc = "Close window" })
map("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>wh", "<C-w>s", { desc = "Close window horizontally" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
