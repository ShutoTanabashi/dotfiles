local env = require("envcfg")

return {
  "numToStr/FTerm.nvim",
  cond = vim.g.vscode ~= 1,
  keys = {
    { "<A-i>", function() require("FTerm").toggle() end, mode = "n" },
    { "<A-i>", function() require("FTerm").toggle() end, mode = "t" },
  },
  opts = env.fterm_opts(),
}
