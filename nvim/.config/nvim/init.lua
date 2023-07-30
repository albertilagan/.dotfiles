-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("notify").setup({
  background_colour = "#000000",
})

vim.o.termguicolors = true
vim.cmd("colorscheme catppuccin")
vim.api.nvim_create_user_command("Exec", "set splitright | vnew | set filetype=sh | read !sh #", {})
