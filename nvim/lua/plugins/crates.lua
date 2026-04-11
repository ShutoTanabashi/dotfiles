local env = require("envcfg")

return {
  "Saecki/crates.nvim",
  enabled = env.enabled_languages.rust,
  ft = "toml",
  opts = {
    lsp = {
      enabled = true,
      on_attach = function(_, _) end,
      actions = true,
      completion = true,
      hover = true,
    },
    completion = {
      cmp = {
        enabled = true,
      },
      crates = {
        enabled = true,
        max_result = 10,
        min_chars = 3,
      },
    },
    null_ls = {
      enabled = true,
      name = "crates.nvim",
    },
  },
}
