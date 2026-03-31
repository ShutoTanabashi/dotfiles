return {
  "machakann/vim-sandwich",
  init = function()
    vim.g.sandwich_no_default_key_mappings = 1
  end,
  config = function()
    vim.keymap.set({ "o", "x" }, "ib", "<Plug>(textobj-sandwich-auto-i)")
    vim.keymap.set({ "o", "x" }, "ab", "<Plug>(textobj-sandwich-auto-a)")
    vim.keymap.set({ "o", "x" }, "is", "<Plug>(textobj-sandwich-query-i)")
    vim.keymap.set({ "o", "x" }, "as", "<Plug>(textobj-sandwich-query-a)")
  end,
  keys = {
    { "<leader>sa", "<Plug>(sandwich-add)", mode = { "n", "x", "o" } },
    { "<leader>sd", "<Plug>(sandwich-delete)", mode = { "n", "x" } },
    { "<leader>sdb", "<Plug>(sandwich-delete-auto)", mode = "n" },
    { "<leader>sr", "<Plug>(sandwich-replace)", mode = { "n", "x" } },
    { "<leader>srb", "<Plug>(sandwich-replace-auto)", mode = "n" },
  },
}
