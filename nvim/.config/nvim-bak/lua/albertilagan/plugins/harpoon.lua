return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set('n', '<C-e>', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { desc = 'Open harpoon menu' })
    keymap.set('n', '<leader>ha', "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = 'Mark file with harpoon' })
    keymap.set('n', '<leader>hn', "<cmd>lua require('harpoon.ui').nav_next()<cr>", { desc = 'Go to next harpoon mark' })
    keymap.set('n', '<leader>hp', "<cmd>lua require('harpoon.ui').nav_prev()<cr>", { desc = 'Go to previous harpoon mark' })
    keymap.set('n', '<leader>a', "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = 'Mark file with harpoon' })
    keymap.set('n', '<leader>1', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = 'Go to #1 harpoon mark' })
    keymap.set('n', '<leader>2', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { desc = 'Go to #2 harpoon mark' })
    keymap.set('n', '<leader>3', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { desc = 'Go to #3 harpoon mark' })
    keymap.set('n', '<leader>4', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", { desc = 'Go to #4 harpoon mark' })
    keymap.set('n', '<leader>5', "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", { desc = 'Go to #5 harpoon mark' })
  end,
}
