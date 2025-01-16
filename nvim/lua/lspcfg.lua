--[[
LSP (Language server protocol) settings for nvim

The extensions conserned LSP have been installed and initialized at `extensions.lua`.
The completetion settings using `nvim-cmp` have also initialized at `extensions.lua`.
This file are defined rest settings, such as keymaps.
]]

local usrlspcfg = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

-- diagnostic signs
-- Using nerd fonts
vim.fn.sign_define("DiagnosticSignError", {
  text = "",
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
})
vim.fn.sign_define("DiagnosticSignWarn", {
  text = "",
  texthl = "DiagnosticSignWarn",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DiagnosticSignInfo", {
  text = "󰭤",
  -- other candidate:  󱁯  󰙎 
  texthl = "DiagnosticSignHint",
  linehl = "",
  numhl = "",
})
vim.fn.sign_define("DiagnosticSignHint", {
  text = "󰛩",
  texthl = "DiagnosticSignHint",
  linehl = "",
  numhl = "",
})

-- keymaps

vim.api.nvim_create_autocmd("LspAttach", {
  group = usrlspcfg,
  callback = function(ev)
    vim.keymap.set('n', 'grr', vim.lsp.buf.references, { buffer = ev.buf })
    vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { buffer = ev.buf })
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

-- nvim-navic
vim.api.nvim_create_autocmd("LspAttach", {
  group = usrlspcfg,
  callback = function()
    vim.wo.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end,
})

-- LSP config
local lspcfg = require("lspconfig")
local opt_lsp = {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

require("mason-lspconfig").setup_handlers({
  function(server)
    lspcfg[server].setup(opt_lsp)
  end,
  ["pyright"] = function()
    lspcfg.pyright.setup({
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      handlers = {
        ["textDocument/publishDiagnostics"] = function() end,
      },
      on_attach = function(client, _)
        client.server_capabilities.codeActionProvider = false
      end,
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
    })
  end,
  ["lua_ls"] = function()
    lspcfg.lua_ls.setup({
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the 'vim' global
            globals = { 'vim' }
          }
        }
      }
    })
  end,
})

-- LSP config installed outside of Mason
if not require("mason-registry").is_installed("clangd") then
  lspcfg.clangd.setup(opt_lsp)
end

-- Linter and Formatter
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.diagnostics.markdownlint,
    require("none-ls.formatting.latexindent"),
  },
})
