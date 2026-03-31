local env = require("envcfg")

return {
  "yuki-yano/fern-preview.vim",
  cond = not env.is_vscode,
  ft = "fern",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fern",
      group = vim.api.nvim_create_augroup("fern-set", { clear = true }),
      callback = function()
        vim.keymap.set("n", "p", "<Plug>(fern-action-preview:toggle)", { silent = true, buffer = true })
        vim.keymap.set("n", "P", "<Plug>(fern-action-preview:auto:toggle)", { silent = true, buffer = true })
        vim.keymap.set("n", "<C-n>", "<Plug>(fern-action-preview:scroll:down:half)", { silent = true, buffer = true })
        vim.keymap.set("n", "<C-p>", "<Plug>(fern-action-preview:scroll:up:half)", { silent = true, buffer = true })
      end,
    })
  end,
}
