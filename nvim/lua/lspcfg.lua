--[[
LSP (Language server protocol) settings for nvim

The extensions conserned LSP have been installed and initialized at `extensions.lua`.
The completetion settings using `nvim-cmp` have also initialized at `extensions.lua`.
This file are defined rest settings, such as keymaps.

Last update: 2024/05/21[00:19]
]]

local usrlspcfg = vim.api.nvim_create_augroup("UserLspConfig", {})

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
--[[
vim.keymap.set("n", "<C-W>d", vim.diagnostic.open_float) -- Now builtined as `<C-W>d`
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev) -- Now builtined as `[d`
vim.keymap.set("n", "]d", vim.diagnostic.goto_next) -- Now builtined as `]d`
]]

vim.api.nvim_create_autocmd("LspAttach", {
	group = usrlspcfg,
	callback = function(ev)
		-- vim.keymap.set('n', 'K',  vim.lsp.buf.hover, { buffer = ev.buf }) -- Now builtined
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf })
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf })
		vim.keymap.set('n', 'gD', function ()
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
		vim.keymap.set('n', 'gn', vim.lsp.buf.rename, { buffer = ev.buf })
		vim.keymap.set({'n', 'v'}, 'ga', vim.lsp.buf.code_action, { buffer = ev.buf })
		vim.keymap.set("n", "gf", function()
			vim.lsp.buf.format({ async = true })
		end, { buffer = ev.buf })
		vim.keymap.set("n", "gl", require("nvim-navbuddy").open)
	end,
})

-- nvim-navic
vim.api.nvim_create_autocmd("LspAttach", {
	group = usrlspcfg,
	callback = function ()
		vim.wo.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
	end,
})

-- Copmletion
require("mason-lspconfig").setup_handlers({
	function(server)
		local opt = {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		}
		require("lspconfig")[server].setup(opt)
	end,
	["pyright"] = function ()
		require("lspconfig").pyright.setup({
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
	["lua_ls"] = function ()
		require("lspconfig").lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						-- Get the language server to recognize the 'vim' global 
						globals= {'vim'}
					}
				}
			}
		})
	end,
})

-- Linter and Formatter
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.diagnostics.markdownlint,
    },
})
