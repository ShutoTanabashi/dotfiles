local env = require("envcfg")

return {
  "windwp/nvim-autopairs",
  cond = not env.is_vscode,
  event = "InsertEnter",
  config = true,
}
