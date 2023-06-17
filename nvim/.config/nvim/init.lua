-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.null-ls")
require("config.prettier")
require("notify").setup({
  background_colour = "#000000",
})

vim.o.termguicolors = true
vim.cmd("colorscheme catppuccin")
