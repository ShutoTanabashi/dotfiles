return {
  "lambdalisue/fern.vim",
  cond = vim.g.vscode ~= 1,
  cmd = "Fern",
  init = function()
    vim.g["fern#default_hidden"] = 1
  end,
  dependencies = {
    {
      "lambdalisue/fern-renderer-nerdfont.vim",
      init = function()
        vim.g["fern#renderer"] = "nerdfont"
      end,
      dependencies = {
        "lambdalisue/nerdfont.vim",
      },
    },
    "lambdalisue/fern-git-status.vim",
  },
  keys = {
    { "<leader>ew", "<Cmd>Fern %:h<CR>", desc = "Open explore at the directory where the current file is located." },
    { "<leader>ee", "<Cmd>Fern %:h -drawer -right<CR>", desc = "Open explore at the directory as drawer" },
    { "<leader>eh", "<Cmd>Fern ~<CR>", desc = "Open explore at home directory" },
    { "<leader>ed", "<Cmd>Fern ~/Desktop<CR>", desc = "Open explore at Desktop" },
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
      desc = "Open explore to new pane",
    },
  },
}
