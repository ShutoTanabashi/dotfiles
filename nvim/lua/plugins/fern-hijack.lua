local env = require("envcfg")

return {
  "lambdalisue/fern-hijack.vim",
  cond = not env.is_vscode,
  lazy = false,
}
