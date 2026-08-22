-- clangd settings
-- Placed in after/lsp/ to take precedence over the nvim-lspconfig defaults.
-- clangd is installed outside of Mason and enabled in `lua/lspcfg.lua`.
return {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
}
