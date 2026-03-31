local env = require("envcfg")

return {
  "rebelot/kanagawa.nvim",
  cond = not env.is_vscode,
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme kanagawa-dragon")
  end,
}
