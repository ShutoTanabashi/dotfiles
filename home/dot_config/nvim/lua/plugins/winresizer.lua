return {
  "simeji/winresizer",
  cond = vim.g.vscode ~= 1,
  keys = {
    { "<C-e>" },
  },
  cmd = "WinResizerStartResize",
}
