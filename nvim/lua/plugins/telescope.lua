local env = require("envcfg")

return {
  "nvim-telescope/telescope.nvim",
  cond = not env.is_vscode,
  branch = "0.1.x",
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
}
