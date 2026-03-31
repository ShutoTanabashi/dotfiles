local env = require("envcfg")

return {
  "tpope/vim-fugitive",
  cond = not env.is_vscode,
  cmd = "Git",
}
