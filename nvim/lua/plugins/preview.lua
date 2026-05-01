local envcfg = require("envcfg")
return {
  "henriklovhaug/Preview.nvim",
  cond = vim.g.vscode ~= 1,
  enabled = envcfg.get_md_preview_plugin() == envcfg.md_preview.options.PREVIEW,
  ft = "markdown",
  config = function()
    require("preview").setup()
  end,
}
