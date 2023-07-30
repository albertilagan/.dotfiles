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
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("harpoon")
      end,
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
          },
        },
      },
    },
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
