local env = require("envcfg")

return {
  "iamcco/markdown-preview.nvim",
  cond = not env.is_vscode,
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  ft = "markdown",
}
