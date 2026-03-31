local env = require("envcfg")

return {
  "simeji/winresizer",
  cond = not env.is_vscode,
  keys = {
    { "<C-e>" },
  },
  cmd = "WinResizerStartResize",
}
