local env = require("envcfg")

return {
  "akinsho/bufferline.nvim",
  cond = not env.is_vscode,
  version = "*",
  event = "TabNew",
  opts = {
    options = {
      mode = "tabs",
      modified_icon = "󱙃",
      max_name_length = 22,
      tab_size = 22,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or ""
        return " " .. icon .. count
      end,
      color_icons = false,
      show_buffer_close_icons = false,
      always_show_bufferline = false,
    },
  },
}
