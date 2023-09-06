return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      -- use fzf for more instant fuzzy grepping.
      -- vim.keymap.set("n", "<c-p>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true, desc = "Files" }),
      vim.keymap.set(
        "n",
        "<c-g>",
        "<cmd>lua require('fzf-lua').grep_project()<CR>",
        { silent = true, desc = "Live Grep" }
      ),
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
          -- require("telescope").load_extension("harpoon")
        end,
      },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          path_display = { "truncate " },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<esc>"] = actions.close,
            },
          },
        },
      })
      telescope.load_extension("fzf")
      -- set keymaps
      local keymap = vim.keymap -- for conciseness

      -- keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
      keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
      keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
      keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    end,
    keys = function()
      return {
        { "<C-p>", "<cmd>Telescope git_files show_untracked=true<cr>", desc = "Find Files (root dir)", remap = true },
        {
          "<leader>pF",
          "<cmd>Telescope git_files show_untracked=true<cr>",
          desc = "Git Files (root dir)",
          remap = true,
        },
        { "<leader>pf", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find Files (root dir)", remap = true },
        { "<C-b>", "<cmd>Telescope buffers<cr>", desc = "All Buffers", remap = true },
        { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live Grep", remap = true },
      }
    end,
  },
}
