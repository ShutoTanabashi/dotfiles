local env = require("envcfg")

return {
  "mrcjkb/rustaceanvim",
  enabled = env.use_extra,
  version = "^4",
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = function()
          vim.lsp.inlay_hint.enable(true)
        end,
      },
    }
  end,
}
