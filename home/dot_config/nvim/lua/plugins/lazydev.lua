return {
  "folke/lazydev.nvim",
  cond = vim.g.vscode ~= 1,
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
