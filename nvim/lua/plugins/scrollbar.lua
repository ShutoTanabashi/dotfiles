local env = require("envcfg")

return {
  "petertriho/nvim-scrollbar",
  cond = not env.is_vscode,
  event = { "BufNewFile", "BufRead" },
  config = function()
    require("scrollbar").setup({
      hide_if_all_visible = true,
    })
    require("scrollbar.handlers.gitsigns").setup()
  end,
}
