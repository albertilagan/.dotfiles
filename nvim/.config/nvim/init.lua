require("albert.core")
require("albert.lazy")

vim.o.termguicolors = true
vim.cmd("colorscheme catppuccin")
vim.api.nvim_create_user_command("Exec", "set splitright | vnew | set filetype=sh | read !sh #", {})

-- let g:silicon = {
--       \   'theme':              'Dracula',
--       \   'shadow-color':       '#555555',
--       \   'line-pad':                   2,
--       \   'pad-horiz':                 80,
--       \   'pad-vert':                 100,
--       \   'shadow-blur-radius':         0,
--       \   'shadow-offset-x':            0,
--       \   'shadow-offset-y':            0,
--       \   'line-number':           v:true,
--       \   'round-corner':          v:true,
--       \   'window-controls':       v:true,
--       \ }
--

vim.g.silicon = {
  background = "#95A0AA",
  theme = "Visual Studio Dark+",
}
