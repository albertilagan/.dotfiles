vim.keymap.set('n', '<leader>qq', ':qa<CR>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<Esc><Esc>', ':noh<cr>')
vim.keymap.set('i', 'kk', '<Esc>', { desc = 'Exit insert mode with jk' })
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit insert mode with jk' })
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode with jk' })
vim.keymap.set('n', 'Y', 'yg$', { silent = true })
vim.keymap.set('n', 'J', 'mzJ`z`', { silent = true })
vim.keymap.set('i', '<A-bs>', '<C-w>')

-- copying and pasting to system clipboard
vim.keymap.set('x', 'p', '"_dP', { silent = true })
vim.keymap.set('n', 'd', '"_d', { silent = true })
vim.keymap.set('v', 'd', '"_d', { silent = true })
vim.keymap.set('n', 'x', '"_x')

-- generate codesnap on selected text (visual mode)
vim.keymap.set(
  'v',
  '<leader>ss',
  -- ":'<,'>Silicon[!]",
  ":'<,'>Silicon ~/screenshot/output.png<CR>",
  { silent = true, desc = 'Silicon (selected)' }
)
-- generate codesnap on the whole buffer (normal mode)
vim.keymap.set('n', '<leader>ss', ':Silicon ~/screenshot/output.png<CR>', { silent = true, desc = 'Silicon (buffer)' })

-- Oil
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
vim.keymap.set('n', '<leader>ed', '<CMD>Oil<CR>', { desc = 'Open parent [d]irectory' })

-- buffer
-- vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = '[d]elete current buffer' })
-- vim.keymap.set('n', '<leader>bD', ':bd!<CR>', { desc = 'Force [D]elete current buffer' })
vim.keymap.set('n', '<leader>bd', ':CloseBuffer<CR>', { desc = '[d]elete current buffer' })
vim.keymap.set('n', '<leader>bD', ':ForceCloseBuffer!<CR>', { desc = 'Force [D]elete current buffer' })
vim.keymap.set('n', '<leader>bb', '<c-^>', { desc = 'Go to previous [b] buffer' })
vim.keymap.set('n', '<leader>bP', ':DeleteAllButCurrentBuffer<CR>', { desc = 'Delete all buffer' })

-- search
vim.keymap.set('n', '<leader>si', ':SearchFolder ')

-- netrw
-- vim.keymap.set('n', '<leader>ed', ':Ex<CR>')

-- better up/down
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })
vim.keymap.set('n', 'n', 'nzzzv', { silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show [D]iagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostic [Q]uickfix list' })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Go to left window', remap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Go to lower window', remap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Go to upper window', remap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Go to right window', remap = true, silent = true })
vim.keymap.set('n', '<leader>rr', '<cmd>Rest run<cr>', { desc = 'Run request under the cursor', remap = true, silent = true })
vim.keymap.set('n', '<leader>zm', '<cmd>ZenMode<cr>', { desc = 'Toggle ZenMode', remap = true, silent = true })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-[>', '<C-w><', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-]>', '<C-w>>', { desc = 'Move focus to the upper window' })

-- better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- save file
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- trouble
vim.keymap.set('n', '<leader>xx', function()
  require('trouble').toggle()
end)
vim.keymap.set('n', '<leader>xw', function()
  require('trouble').toggle 'workspace_diagnostics'
end)
vim.keymap.set('n', '<leader>xd', function()
  require('trouble').toggle 'document_diagnostics'
end)
vim.keymap.set('n', '<leader>xq', function()
  require('trouble').toggle 'quickfix'
end)
vim.keymap.set('n', '<leader>xl', function()
  require('trouble').toggle 'loclist'
end)
vim.keymap.set('n', 'gR', function()
  require('trouble').toggle 'lsp_references'
end)

-- DB dadbod
vim.keymap.set('n', '<leader>db', ':DBUIToggle<CR>', { desc = 'Toggle dadbod' })

-- git
vim.keymap.set('n', '<leader>gg', ':Neogit<CR>', { desc = '[G]it' })
vim.keymap.set('n', '<leader>gc', ':Neogit commit<CR>', { desc = '[Git [C]ommit' })
vim.keymap.set('n', '<leader>gwl', function()
  require('telescope').extensions.git_worktree.git_worktrees()
end, { desc = '[G]it Worktree' })
vim.keymap.set('n', '<leader>gwc', function()
  require('telescope').extensions.git_worktree.create_git_worktree()
end, { desc = 'Create [G]it Worktree' })
