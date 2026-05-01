return {
  "henriklovhaug/Preview.nvim",
  cond = vim.g.vscode ~= 1,
  ft = "markdown",
  config = function()
    require("preview").setup()
  end,
}
