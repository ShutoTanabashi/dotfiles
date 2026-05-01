local envcfg = require("envcfg")
return {
  "topazape/md-preview.nvim",
  cond = vim.g.vscode ~= 1,
  enabled = envcfg.get_md_preview_plugin() == envcfg.md_preview.options.MD_PREVIEW,
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
