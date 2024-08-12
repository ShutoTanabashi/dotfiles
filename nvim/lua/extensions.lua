--[[
Extention settings for neovim
]]

-- Related variables
vim.g.sandwich_no_default_key_mappings = 1 -- for vim-sandwich
vim.g.golden_ratio_autocommand = 0         -- for golden-ratio: Disable auto resize

-- lazy.nvim: Package manager
-- bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Extensions
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
  {
    "David-Kunz/treesitter-unit",
    event = "ModeChanged",
    config = function()
      vim.keymap.set("x", "iu", ":lua require('treesitter-unit').select()<CR>", { noremap = true })
      vim.keymap.set("x", "au", ":lua require('treesitter-unit').select(true)<CR>", { noremap = true })
      vim.keymap.set("o", "iu", ":<C-u>lua require('treesitter-unit').select()<CR>", { noremap = true })
      vim.keymap.set("o", "au", ":<C-u>lua require('treesitter-unit').select(true)<CR>", { noremap = true })
    end
  },
  {
    "arnar/vim-matchopen",
    event = { "BufNewFile", "BufRead" },
  },
  --[[ {
    "m4xshen/autoclose.nvim",
    event = "InsertEnter",
    opts = {
      keys = {
        ["<"] = { escape = true, close = true, pair = "<>", enabled_filetypes = { "rust" } },
        ["`"] = { escape = true, close = true, pair = "``", enabled_filetypes = { "markdown", "rust" } },
        ["`"] = { escape = true, close = true, pair = "`'", enabled_filetypes = { "tex" } },
        ["$"] = { escape = true, close = true, pair = "$$", enabled_filetypes = { "tex" } },
      },
    },
  }, ]]
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
    "lambdalisue/fern-hijack.vim",
    lazy = false,
  },
  {
    "lambdalisue/fern.vim",
    cmd = "Fern",
    dependencies = {
      {
        "lambdalisue/fern-renderer-nerdfont.vim",
        dependencies = {
          "lambdalisue/nerdfont.vim",
        },
        config = function()
          vim.g['fern#renderer'] = 'nerdfont'
        end,
      },
      "lambdalisue/fern-git-status.vim",
    },
    keys = {
      { "<leader>ew", "<Cmd>Fern %:h<CR>",                desc = "Open explore at the directory where the current file is located." },
      { "<leader>ee", "<Cmd>Fern %:h -drawer -right<CR>", desc = "Open explore at the directory as drawer" },
      { "<leader>eh", "<Cmd>Fern ~<CR>",                  desc = "Open explore at home directory" },
      { "<leader>ed", "<Cmd>Fern ~/Desktop<CR>",          desc = "Open explore at Desktop" },
      {
        "<leader>en",
        function()
          if vim.fn.winwidth(0) > (2 * vim.fn.winheight(0)) then
            vim.cmd("vsplit")
          else
            vim.cmd("split")
          end
          vim.cmd("Fern %:h")
        end,
        desc = "Open explore to new pane"
      },
    },
    config = function()
      vim.g['fern#default_hidden'] = 1 -- Show hidden file
    end,
  },
  {
    "yuki-yano/fern-preview.vim",
    ft = "fern",
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'fern',
        group = vim.api.nvim_create_augroup('fern-set', { clear = true }),
        callback = function()
          vim.keymap.set('n', 'p', '<Plug>(fern-action-preview:toggle)', { silent = true, buffer = true })
          vim.keymap.set('n', 'P', '<Plug>(fern-action-preview:auto:toggle)', { silent = true, buffer = true })
          vim.keymap.set('n', '<C-n>', '<Plug>(fern-action-preview:scroll:down:half)', { silent = true, buffer = true })
          vim.keymap.set('n', '<C-p>', '<Plug>(fern-action-preview:scroll:up:half)', { silent = true, buffer = true })
        end,
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "TabNew",
    opts = {
      options = {
        mode = "tabs",
        modified_icon = "󱙃",
        max_name_length = 22,
        tab_size = 22,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or ""
          return " " .. icon .. count
        end,
        color_icons = false,
        show_buffer_close_icons = false,
        always_show_bufferline = false,
      }
    },
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "lfilho/cosco.vim",
    keys = {
      { "<C-;>", "<Plug>(cosco-commaOrSemiColon)",       mode = "n", silent = true },
      { "<C-;>", "<Esc><Plug>(cosco-commaOrSemiColon)o", mode = "i", silent = true },
      { "<A-;>", "<Plug>(cosco-commaOrSemiColon)",       mode = "n", silent = true },
      { "<A-;>", "<Esc><Plug>(cosco-commaOrSemiColon)o", mode = "i", silent = true },
    },
  },
  {
    "machakann/vim-sandwich",
    -- event = "VeryLazy",
    config = function()
      vim.keymap.set({ "o", "x" }, "ib", "<Plug>(textobj-sandwich-auto-i)")
      vim.keymap.set({ "o", "x" }, "ab", "<Plug>(textobj-sandwich-auto-a)")
      vim.keymap.set({ "o", "x" }, "is", "<Plug>(textobj-sandwich-query-i)")
      vim.keymap.set({ "o", "x" }, "as", "<Plug>(textobj-sandwich-query-a)")
    end,
    keys = {
      { "<leader>sa",  "<Plug>(sandwich-add)",          mode = { "n", "x", "o" } },
      { "<leader>sd",  "<Plug>(sandwich-delete)",       mode = { "n", "x" } },
      { "<leader>sdb", "<Plug>(sandwich-delete-auto)",  mode = "n" },
      { "<leader>sr",  "<Plug>(sandwich-replace)",      mode = { "n", "x" } },
      { "<leader>srb", "<Plug>(sandwich-replace-auto)", mode = "n" },
    },
  },
  {
    "kevinhwang91/nvim-hlslens",
    dependencies = {
      "haya14busa/vim-asterisk",
    },
    keys = {
      { "n",         [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], noremap = true,           silent = true },
      { "N",         [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], noremap = true,           silent = true },
      { "*",         [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],                           mode = { "n", "v", "o" }, noremap = true, silent = true },
      { "#",         [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],                           mode = { "n", "v", "o" }, noremap = true, silent = true },
      { "g*",        [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]],                          mode = { "n", "v", "o" }, noremap = true, silent = true },
      { "g#",        [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]],                          mode = { "n", "v", "o" }, noremap = true, silent = true },
      { "<Leader>l", function() vim.cmd("noh") end,                                                            noremap = true,           silent = true },
    },
    config = function()
      require("hlslens").setup()
      require("scrollbar.handlers.search").setup()
      --[[
  Worning:  Default setting for showing search location is not working.
  Git Hub issue page: https://github.com/petertriho/nvim-scrollbar/issues/83
  Last update: 2023/05/11[02:45]
  --]]
    end,
  },
  {
    "numToStr/FTerm.nvim",
    keys = {
      { "<A-i>", function() require('FTerm').toggle() end, mode = "n" },
      { "<A-i>", function() require('FTerm').toggle() end, mode = "t" },
    },
    opts = CfgFTerm(),
  },
  {
    "roman/golden-ratio",
    keys = {
      { "<leader>rs", "<Plug>(golden_ratio_resize)", silent = true, desc = 'Pane size adjustment' },
      { "<leader>rS", "<Plug>(golden_ratio_toggle)", silent = true, desc = 'Pane size adjustment' },
    },
    cmd = { "GoldenRatioResize", "GoldenRatioToggle" },
  },
  {
    "simeji/winresizer",
    keys = {
      { "<C-e>" }
    },
    cmd = "WinResizerStartResize",
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      -- "hrsh7th/cmp-nvim-lsp", -- This plugin load at "mason-lspconfig"
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "f3fora/cmp-spell",
      {
        "dcampos/nvim-snippy",
        opts = {
          mappings = {
            is = {
              ['<Tab>'] = 'expand_or_advance',
              ['<S-Tab>'] = 'previous',
            },
            nx = {
              ['<leader>x'] = 'cut_text',
            },
          },
        },
      },
      "dcampos/cmp-snippy",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("snippy").expand_snippet(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<A-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp_document_symbol" },
          { name = "crates" },
          { name = 'snippy' },
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
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
          }),
        },
      })
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        },
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  },
  {
    "gbprod/yanky.nvim",
    opts = {
      ring = {
        history_length = 20,
      },
      highlight = {
        on_put = false,
        on_yank = false, -- The highlighting at yank is set by myself.
      },
      system_clipboard = {
        sync_with_ring = true,
      },
    },
    keys = {
      { "p",     "<Plug>(YankyPutAfter)",               mode = { "n", "x" } },
      { "P",     "<Plug>(YankyPutBefore)",              mode = { "n", "x" } },
      { "gp",    "<Plug>(YankyGPutAfter)",              mode = { "n", "x" } },
      { "gP",    "<Plug>(YankyGPutBefore)",             mode = { "n", "x" } },
      { "]p",    "<Plug>(YankyPutIndentAfterLinewise)" },
      { "[p",    "<Plug>(YankyPutIndentBeforeLinewise)" },
      { "]P",    "<Plug>(YankyPutIndentAfterLinewise)" },
      { "[P",    "<Plug>(YankyPutIndentBeforeLinewise)" },
      { "<c-p>", "<Plug>(YankyCycleForward)" },
      { "<c-n>", "<Plug>(YankyCycleBackward)" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      {
        "folke/neodev.nvim",
        opts = {},
      },
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts = {},
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "clangd",
            "lua_ls",
            "marksman",
            "pyright",
            "ruff_lsp",
            "taplo",
            "texlab",
          },
        },
        dependencies = {},
      },
      {
        "nvimtools/none-ls.nvim",
        -- Module name is `null-ls`
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        -- Initial settings are defined at `lua/lspconf.lua`
      },
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          {
            "SmiteshP/nvim-navic",
            opts = {
              lsp = {
                auto_attach = true,
              },
            },
          },
          "MunifTanjim/nui.nvim",
        },
        opts = {
          lsp = {
            auto_attach = true,
          },
        },
      },
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    tag = "legacy",
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<Cmd>Telescope find_files<CR>" },
      { "<leader>fg", "<Cmd>Telescope live_grep<CR>" },
      { "<leader>fb", "<Cmd>Telescope buffers<CR>" },
      { "<leader>fh", "<Cmd>Telescope help_tags<CR>" },
      { "<leader>fk", "<Cmd>Telescope keymaps<CR>" },
      { "<leader>fy", function() require("telescope").extensions.yank_history.yank_history() end },
      { "<leader>fl", "<Cmd>Telescope lsp_document_symbols<CR>" },
    },
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      chunk = {
        enable = true,
        delay = 0,
      },
    },
  },
  {
    "petertriho/nvim-scrollbar",
    event = { "BufNewFile", "BufRead" },
    config = function()
      require("scrollbar").setup({
        hide_if_all_visible = true,
      })
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signcolumn = false,
      numhl = true,
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerReloadAllBuffer",
      "ColorizerToggle",
    },
    opts = {},
  },
  {
    "tpope/vim-fugitive",
    cmd = "Git",
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false,   -- This plugin is already lazy
    dependencies = {
      "mfussenegger/nvim-dap"
    },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function()
            vim.lsp.inlay_hint.enable(true)
          end,
        },
      }
    end
  },
  {
    "Saecki/crates.nvim",
    ft = "toml",
    opts = {
      lsp = {
        enabled = true,
        on_attach = function(client, bufnr) end,
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
        }
      },
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    'hat0uma/csvview.nvim',
    ft = "csv",
    opts = {
      parser = {
        --- The number of lines that the asynchronous parser processes per cycle.
        --- This setting is used to prevent monopolization of the main thread when displaying large files.
        --- If the UI freezes, try reducing this value.
        async_chunksize = 50,
      },
      view = {
        --- minimum width of a column
        min_column_width = 5,
        --- spacing between columns
        spacing = 2,
      },
    }
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
  },
  {
    "topazape/md-preview.nvim",
    ft = { "md", "markdown", "mkd", "mkdn", "mdwn", "mdown", "mdtxt", "mdtext", "rmd", "wiki" },
    opts = {
      viewer = {
        exec = "glow",
        exec_path = "",
        args = { "-s", "dark" },
      },
      -- Markdown preview term
      term = {
        -- reload term when rendered markdown file changed
        reload = {
          enable = true,
          events = { "InsertLeave", "TextChanged" },
        },
        direction = "vertical", -- choices: vertical / horizontal
        keys = {
          close = { "q" },
          refresh = "r",
        },
      },
    }
  },
  {
    "lervag/vimtex",
    -- Lazy load causes an error of synctex's inverse search.
    -- Detail: https://github.com/lervag/vimtex/issues/2876
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = vim.g.pdf_viewer
      -- Use llmk(Light LaTeX Make)
      vim.g.vimtex_compiler_method = "generic"
      vim.g.vimtex_compiler_generic = { command = "llmk" }
    end
  },
  -- colorschemes
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme kanagawa-dragon")
    end,
  },
  {
    "cocopon/iceberg.vim",
    lazy = true,
  },
  {
    "aktersnurra/no-clown-fiesta.nvim",
    lazy = true,
  },
  {
    "machakann/vim-colorscheme-reki",
    lazy = true,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
  }
})

-- Extension-related autocmd
-- For yanky.nvim
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank { higroup = "DiagnosticUnderlineWarn" } end,
  desc = "Briefly highlight yanked text",
  group = vim.api.nvim_create_augroup("YankSetting", { clear = true })
})
-- For csvview.nvim
vim.api.nvim_create_autocmd("FileType", {
  -- pattern = '*.csv',
  -- command = "CsvViewEnable",
  callback = function(args)
    if args.match == "csv" then
      vim.cmd("CsvViewEnable")
    end
  end,
  group = vim.api.nvim_create_augroup("CSVInitialize", { clear = true })
})
-- For VimTeX
vim.api.nvim_create_autocmd("bufWritePost", {
  pattern = "*.tex",
  command = "VimtexCompile",
  group = vim.api.nvim_create_augroup("EditTeX", { clear = true })
})
