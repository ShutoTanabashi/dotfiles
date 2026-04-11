return {
  "j-hui/fidget.nvim",
  cond = vim.g.vscode ~= 1,
  event = "LspAttach",
  tag = "legacy",
  opts = {},
}
