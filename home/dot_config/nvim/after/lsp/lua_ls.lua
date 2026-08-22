-- lua_ls settings
-- Placed in after/lsp/ to take precedence over the nvim-lspconfig defaults.
return {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the 'vim' global
        globals = { 'vim' }
      }
    }
  }
}
