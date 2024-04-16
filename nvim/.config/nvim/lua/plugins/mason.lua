return {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup({
      ensure_installed = {
        "stylua",
        "shfmt",
        "prisma-language-server",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
  end,
}
