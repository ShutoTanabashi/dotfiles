local env = require("envcfg")

return {
  "nvim-treesitter/nvim-treesitter",
  cond = not env.is_vscode,
  event = "VeryLazy",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
}
