return {
  "iamcco/markdown-preview.nvim",
  enabled = function()
    local sysname = vim.loop.os_uname().sysname
    if sysname == "Linux" then
      return not not (vim.env.DISPLAY or vim.env.WAYLAND_DISPLAY)
    end
    return true
  end,
  cond = vim.g.vscode ~= 1,
  build = "cd app && npm install",
  ft = { "markdown" },
}
