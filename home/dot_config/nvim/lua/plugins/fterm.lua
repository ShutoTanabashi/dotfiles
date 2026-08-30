-- Windows doesn't have `$SHELL` environment variable, so must set them.
local cmd = vim.uv.os_uname().sysname == "Windows" and "pwsh.exe"or os.getenv('SHELL')

return {
  "numToStr/FTerm.nvim",
  cond = vim.g.vscode ~= 1,
  keys = {
    { "<A-i>", function() require("FTerm").toggle() end, mode = "n" },
    { "<A-i>", function() require("FTerm").toggle() end, mode = "t" },
  },
  opts = {
    cmd = cmd,
    dimensions = {
      height = 0.9,
      width = 0.9,
    },
  },
}
