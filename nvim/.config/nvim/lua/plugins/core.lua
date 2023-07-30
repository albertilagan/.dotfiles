return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  { "prisma/vim-prisma" },
  { "ThePrimeagen/vim-be-good" },
  { "yasuhiroki/github-actions-yaml.vim" },
  -- { "prettier/vim-prettier" },
  { "nvim-lua/plenary.nvim" },
  { "ThePrimeagen/harpoon" },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      { "williamboman/mason.nvim" }, -- Optional
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" }, -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" }, -- Required
    },
  },
  { "zbirenbaum/copilot.lua" },
  { "zbirenbaum/copilot-cmp" },
}
