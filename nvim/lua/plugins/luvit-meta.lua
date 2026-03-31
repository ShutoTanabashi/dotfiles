local env = require("envcfg")

return {
  "Bilal2453/luvit-meta",
  cond = not env.is_vscode,
  lazy = true,
}
