require("albert.core")
require("albert.lazy")

vim.o.termguicolors = true
vim.cmd("colorscheme catppuccin")
vim.api.nvim_create_user_command("Exec", "set splitright | vnew | set filetype=sh | read !sh #", {})
