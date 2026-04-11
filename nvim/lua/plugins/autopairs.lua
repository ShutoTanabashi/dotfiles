return {
  "windwp/nvim-autopairs",
  cond = vim.g.vscode ~= 1,
  event = "InsertEnter",
  config = true,
}
