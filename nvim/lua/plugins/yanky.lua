return {
  "gbprod/yanky.nvim",
  init = function()
    vim.api.nvim_create_autocmd("TextYankPost", {
      callback = function()
        vim.highlight.on_yank({ higroup = "DiagnosticUnderlineWarn" })
      end,
      desc = "Briefly highlight yanked text",
      group = vim.api.nvim_create_augroup("YankSetting", { clear = true }),
    })
  end,
  opts = {
    ring = {
      history_length = 20,
    },
    highlight = {
      on_put = false,
      on_yank = false,
    },
    system_clipboard = {
      sync_with_ring = true,
    },
  },
  keys = {
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
    { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" } },
    { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" } },
    { "]p", "<Plug>(YankyPutIndentAfterLinewise)" },
    { "[p", "<Plug>(YankyPutIndentBeforeLinewise)" },
    { "]P", "<Plug>(YankyPutIndentAfterLinewise)" },
    { "[P", "<Plug>(YankyPutIndentBeforeLinewise)" },
    { "<c-p>", "<Plug>(YankyCycleForward)" },
    { "<c-n>", "<Plug>(YankyCycleBackward)" },
  },
}
