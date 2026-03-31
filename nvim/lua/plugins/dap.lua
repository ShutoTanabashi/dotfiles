local env = require("envcfg")

return {
  "mfussenegger/nvim-dap",
  cond = not env.is_vscode,
  lazy = true,
}
