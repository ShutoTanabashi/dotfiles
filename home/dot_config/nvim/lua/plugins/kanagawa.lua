return {
  "rebelot/kanagawa.nvim",
  cond = vim.g.vscode ~= 1,
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme kanagawa-dragon")
  end,
}
