return {
  "iamcco/markdown-preview.nvim",
  cond = vim.g.vscode ~= 1,
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  ft = "markdown",
}
