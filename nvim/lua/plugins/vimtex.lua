local env = require("envcfg")

return {
  "lervag/vimtex",
  enabled = env.use_extra,
  lazy = false,
  init = function()
    if env.pdf_viewer_options then
      vim.g.vimtex_view_general_viewer = env.pdf_viewer
      vim.g.vimtex_view_general_options = env.pdf_viewer_options
    else
      vim.g.vimtex_view_method = env.pdf_viewer
    end
    vim.g.vimtex_compiler_method = "generic"
    vim.g.vimtex_compiler_generic = { command = "llmk" }
  end,
}
