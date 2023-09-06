return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "prettierd",
        "prettier",
        "yaml-language-server",
        "typescript-language-server",
        "tailwindcss-language-server",
      },
    },
  },
}
