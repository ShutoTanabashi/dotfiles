return {
  "topazape/md-preview.nvim",
  enabled = vim.fn.has("unix") == 1,
  ft = { "md", "markdown", "mkd", "mkdn", "mdwn", "mdown", "mdtxt", "mdtext", "rmd", "wiki" },
  opts = {
    viewer = {
      exec = "glow",
      exec_path = "",
      args = { "-s", "dark" },
    },
    term = {
      reload = {
        enable = true,
        events = { "InsertLeave", "TextChanged" },
      },
      direction = "vertical",
      keys = {
        close = { "q" },
        refresh = "r",
      },
    },
  },
}
