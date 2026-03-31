local env = require("envcfg")

return {
  "David-Kunz/treesitter-unit",
  enabled = env.use_extra,
  event = "ModeChanged",
  config = function()
    vim.keymap.set("x", "iu", ":lua require('treesitter-unit').select()<CR>", { noremap = true })
    vim.keymap.set("x", "au", ":lua require('treesitter-unit').select(true)<CR>", { noremap = true })
    vim.keymap.set("o", "iu", ":<C-u>lua require('treesitter-unit').select()<CR>", { noremap = true })
    vim.keymap.set("o", "au", ":<C-u>lua require('treesitter-unit').select(true)<CR>", { noremap = true })
  end,
}
