return {
  "shellRaining/hlchunk.nvim",
  cond = vim.g.vscode ~= 1,
  event = "VeryLazy",
  opts = {
    chunk = {
      enable = true,
      delay = 0,
    },
  },
}
