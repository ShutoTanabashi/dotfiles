return {
  "kevinhwang91/nvim-hlslens",
  cond = vim.g.vscode ~= 1,
  dependencies = {
    "haya14busa/vim-asterisk",
  },
  keys = {
    { "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], noremap = true, silent = true },
    { "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], noremap = true, silent = true },
    { "*", [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], mode = { "n", "v", "o" }, noremap = true, silent = true },
    { "#", [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], mode = { "n", "v", "o" }, noremap = true, silent = true },
    { "g*", [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], mode = { "n", "v", "o" }, noremap = true, silent = true },
    { "g#", [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], mode = { "n", "v", "o" }, noremap = true, silent = true },
    { "<Leader>l", function() vim.cmd("noh") end, noremap = true, silent = true },
  },
  config = function()
    require("hlslens").setup()
    require("scrollbar.handlers.search").setup()
  end,
}
