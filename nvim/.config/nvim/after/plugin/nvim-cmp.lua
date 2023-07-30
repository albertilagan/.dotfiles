local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = "copilot" },
    { name = "nvim_lsp" },
  },
})
