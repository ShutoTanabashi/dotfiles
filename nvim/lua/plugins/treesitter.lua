local version = vim.version()
local use_main = version.major > 0 or (version.major == 0 and version.minor >= 12)

return {
  "nvim-treesitter/nvim-treesitter",
  cond = vim.g.vscode ~= 1,
  lazy = false,
  branch = use_main and "main" or "master",
  build = ":TSUpdate",
  main = use_main and "nvim-treesitter" or "nvim-treesitter.configs",
  init = function()
    if not use_main then
      return
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
  opts = use_main and {} or {
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
}
