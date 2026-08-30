return {
  "roman/golden-ratio",
  cond = vim.g.vscode ~= 1,
  init = function()
    vim.g.golden_ratio_autocommand = 0
  end,
  keys = {
    { "<leader>rs", "<Plug>(golden_ratio_resize)", silent = true, desc = "Pane size adjustment" },
    { "<leader>rS", "<Plug>(golden_ratio_toggle)", silent = true, desc = "Pane size adjustment" },
  },
  cmd = { "GoldenRatioResize", "GoldenRatioToggle" },
}
