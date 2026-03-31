local env = require("envcfg")

return {
  "shellRaining/hlchunk.nvim",
  cond = not env.is_vscode,
  event = "VeryLazy",
  opts = {
    chunk = {
      enable = true,
      delay = 0,
    },
  },
}
