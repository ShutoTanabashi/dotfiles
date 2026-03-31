local env = require("envcfg")

return {
  "j-hui/fidget.nvim",
  cond = not env.is_vscode,
  event = "LspAttach",
  tag = "legacy",
  opts = {},
}
