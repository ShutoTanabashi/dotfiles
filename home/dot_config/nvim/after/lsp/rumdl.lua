-- rumdl settings
-- Placed in after/lsp/ to take precedence over the nvim-lspconfig defaults.
-- rumdl is installed outside of Mason and enabled in `lua/lspcfg.lua`.
return {
  cmd = { "rumdl", "server" },
  filetypes = { "markdown" },
  root_markers = { ".git" },
}
