return {
  "neovim/nvim-lspconfig",
  cond = vim.g.vscode ~= 1,
  lazy = false,
  dependencies = {
    {
      "mason-org/mason.nvim",
      build = ":MasonUpdate",
      opts = {},
      lazy = false,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {
          "lua_ls",
          "marksman",
          "pyright",
        },
      },
      lazy = false,
    },
    {
      "nvimtools/none-ls.nvim",
      lazy = false,
    },
  },
}
