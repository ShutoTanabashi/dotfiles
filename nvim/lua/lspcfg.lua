--[[
LSP (Language server protocol) settings for nvim

The extensions conserned LSP have been installed and initialized at `extensions.lua`.
The completetion settings using `nvim-cmp` have also initialized at `extensions.lua`.
This file are defined rest settings, such as keymaps.
]]

local usrlspcfg = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

-- diagnostic signs
-- Using nerd fonts
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "󰭤",
      -- other candidate:  󱁯  󰙎 
      [vim.diagnostic.severity.HINT] = "󰛩",
    },
  },
})

-- keymaps

vim.api.nvim_create_autocmd("LspAttach", {
  group = usrlspcfg,
  callback = function(ev)
    vim.keymap.set({ 'n', 'v' }, 'gra', vim.lsp.buf.code_action, { buffer = ev.buf })
    vim.keymap.set('n', '<C-w>]', function()
      -- Orverwrite default keymap to adjust the location of new pane.
      if vim.fn.winwidth(0) > (2 * vim.fn.winheight(0)) then
        vim.cmd("vsplit")
      else
        vim.cmd("split")
      end
      vim.lsp.buf.definition()
    end, { buffer = ev.buf })
    vim.keymap.set('n', 'gC', vim.lsp.buf.declaration, { buffer = ev.buf })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf })
    vim.keymap.set('n', 'ge', vim.lsp.buf.type_definition, { buffer = ev.buf })
    vim.keymap.set("n", "gf", function()
      vim.lsp.buf.format({ async = true })
    end, { buffer = ev.buf })
  end,
})

-- -- Inlay hint
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group = usrlspcfg,
  callback = function()
    vim.lsp.inlay_hint.enable(true, { 0 })
  end,
})

-- LSP config
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("pyright", {
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
  capabilities = cmp_capabilities,
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end,
  },
})

vim.lsp.config("lua_ls", {
  capabilities = cmp_capabilities,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the 'vim' global
        globals = { 'vim' }
      }
    }
  }
}
)

-- LSP config installed outside of Mason
vim.lsp.config("clangd", {
  capabilities = cmp_capabilities,
})
vim.lsp.enable("clangd")

vim.lsp.config("rumdl", {
  cmd = { "rumdl", "server" },
  filetypes = { "markdown" },
  root_markers = { ".git" },
})
vim.lsp.enable("rumdl")
