return {
  "lewis6991/gitsigns.nvim",
  cond = vim.g.vscode ~= 1,
  event = "VeryLazy",
  opts = {
    signcolumn = false,
    numhl = true,
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      vim.keymap.set("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { buffer = bufnr, desc = "Next hunk" })

      vim.keymap.set("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { buffer = bufnr, desc = "Previous hunk" })

      vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, {
        buffer = bufnr,
        desc = "Stage hunk",
      })

      vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, {
        buffer = bufnr,
        desc = "Reset hunk",
      })

      vim.keymap.set("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, {
        buffer = bufnr,
        desc = "Stage hunk",
      })

      vim.keymap.set("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, {
        buffer = bufnr,
        desc = "Reset hunk",
      })

      vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, {
        buffer = bufnr,
        desc = "Preview hunk",
      })

      vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, {
        buffer = bufnr,
        desc = "Diff this",
      })

      vim.keymap.set("n", "<leader>hQ", function()
        gitsigns.setqflist("all")
      end, {
        buffer = bufnr,
        desc = "Hunks to quickfix (all)",
      })

      vim.keymap.set("n", "<leader>hq", gitsigns.setqflist, {
        buffer = bufnr,
        desc = "Hunks to quickfix",
      })

      vim.keymap.set({ "o", "x" }, "ih", gitsigns.select_hunk, {
        buffer = bufnr,
        desc = "Select hunk",
      })
    end,
  },
}
