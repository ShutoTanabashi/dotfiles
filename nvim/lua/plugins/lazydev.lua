local env = require("envcfg")

return {
  "folke/lazydev.nvim",
  cond = not env.is_vscode,
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
