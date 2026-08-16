-- pyright settings
-- Placed in after/lsp/ to take precedence over the nvim-lspconfig defaults.
return {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        autoSearchPaths = true,
        typeCheckingMode = "basic",
        useLibraryCodeForTypes = true,
      },
    },
  },
  on_attach = function(client, _)
    client.server_capabilities.codeActionProvider = false
  end,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end,
  },
}
