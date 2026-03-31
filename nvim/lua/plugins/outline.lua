local env = require("envcfg")

return {
  "hedyhli/outline.nvim",
  cond = not env.is_vscode,
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "gn", "<cmd>Outline<CR>", mode = "n", desc = "Show table of contens on the side." },
  },
  opts = {
    outline_window = {
      auto_close = true,
      shou_cursorline = true,
      hide_cursor = true,
    },
    preview_window = {
      auto_preview = true,
      open_hover_on_preview = true,
      width = 50,
      height = 80,
      winblend = 15,
    },
    providers = {
      priority = { "lsp", "treesitter" },
    },
  },
}
