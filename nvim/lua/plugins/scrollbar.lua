return {
  "petertriho/nvim-scrollbar",
  cond = vim.g.vscode ~= 1,
  event = { "BufNewFile", "BufRead" },
  config = function()
    require("scrollbar").setup({
      hide_if_all_visible = true,
    })
    require("scrollbar.handlers.gitsigns").setup()
  end,
}
