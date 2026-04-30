local env = require("envcfg")

return {
  "hrsh7th/nvim-cmp",
  cond = vim.g.vscode ~= 1,
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "f3fora/cmp-spell",
    {
      "dcampos/nvim-snippy",
      opts = {
        mappings = {
          is = {
            ["<Tab>"] = "expand_or_advance",
            ["<S-Tab>"] = "previous",
          },
          nx = {
            ["<leader>x"] = "cut_text",
          },
        },
      },
    },
    "dcampos/cmp-snippy",
    "onsails/lspkind.nvim",
    env.llm.enabled and "milanglacier/minuet-ai.nvim" or nil,
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    local sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "nvim_lsp_document_symbol" },
      { name = "crates" },
      { name = "snippy" },
      { name = "buffer" },
      { name = "path" },
      {
        name = "spell",
        option = {
          keep_all_entries = false,
          enable_in_context = function()
            return true
          end,
        },
      },
      {
        name = "lazydev",
        group_index = 0,
      },
    }

    if env.llm.enabled then
      table.insert(sources, { name = "minuet" })
    end

    local mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<A-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    })

    if env.llm.enabled then
      mapping["<A-y>"] = require("minuet").make_cmp_map()
    end

    cmp.setup({
      snippet = {
        expand = function(args)
          require("snippy").expand_snippet(args.body)
        end,
      },
      mapping = mapping,
      sources = cmp.config.sources(sources),
      performance = {
        fetching_timeout = env.llm.enabled and 2000 or 500,
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol",
        }),
      },
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
