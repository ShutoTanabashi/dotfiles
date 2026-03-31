local env = require("envcfg")

return {
  "neovim/nvim-lspconfig",
  cond = not env.is_vscode,
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
