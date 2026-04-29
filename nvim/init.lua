--[[
NeoVim setting file
]]
vim.loader.enable()

-- Editor settings
vim.g.mapleader = ' ' -- Space key
if not vim.g.vscode then
  vim.o.wrap = true
  vim.o.number = true
  vim.o.relativenumber = true
  vim.o.splitbelow = true
  vim.o.splitright = true
  vim.opt.listchars = { tab = ">.", trail = "·", nbsp = "~", eol = "󰌑" }
  vim.opt.list = true
  vim.g.fileencodings = { 'utf-8', 'sjis', 'utf-16le', 'default', 'ucs-bom', 'latin1' }
end

-- Clipboard
vim.o.clipboard = 'unnamedplus'
if vim.fn.executable("wl-copy") == 1 and vim.fn.executable("wl-paste") == 1 then
  vim.g.clipboard = {
    -- clipboard config for Linux (include WSL)
    name = "wl-clipboard",
    copy = {
      ["+"] = 'wl-copy --foreground --type text/plain',
      ["*"] = 'wl-copy --foreground --primary --type text/plain',
    },
    paste = {
      ["+"] = function()
        return vim.fn.systemlist('wl-paste --no-newline|sed -e "s/\r$//"', { "" }, 1)
      end,
      ["*"] = function()
        return vim.fn.systemlist('wl-paste --primary --no-newline|sed -e "s/\r$//"', { "" }, 1)
      end,
    },
    cache_enabled = true,
  }
end

-- Settings for comments environment
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("FormatOptions", { clear = true }),
  pattern = { "*" },
  callback = function()
    vim.opt.formatoptions:remove("o") -- Add new line without comment enviromnent.
  end,
})

-- tabstop settings
if not vim.g.vscode then
  vim.o.expandtab = true
  vim.o.tabstop = 4
  vim.o.shiftwidth = 4
  -- Change tabwidth by filetype
  local filetype_tabstop = { lua = 2, c = 2, cpp = 2 }
  local usrftcfg = vim.api.nvim_create_augroup("UserFileTypeConfig", { clear = true })
  -- Use tab charactor for indent
  local filetype_usetab = { latex = true, tex = true }
  vim.api.nvim_create_autocmd("FileType", {
    group = usrftcfg,
    callback = function(args)
      local ftts = filetype_tabstop[args.match]
      if ftts then
        vim.bo.tabstop = ftts
        vim.bo.shiftwidth = ftts
      elseif filetype_usetab[args.match] then
        vim.bo.expandtab = false
      end
    end
  })
end

-- Settngs for terminal
if not vim.g.vscode then
  vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
  vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('term', { clear = true }),
    callback = function()
      vim.opt_local.number = false
      vim.cmd("startinsert")
    end,
  })
end

-- Spell settings
vim.opt.spelllang = 'en,cjk'
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "gitcommit", "markdown" },
  callback = function() vim.opt_local.spell = true end
})

-- OS dependent settings
if vim.uv.os_uname().sysname == "Darwin" then
  vim.keymap.set('!', '¥', '\\', { noremap = true })
  vim.keymap.set('!', '\\', '¥', { noremap = true })
end

-- Load separated setting files
require("envcfg")
require("config.lazy")
if not vim.g.vscode then
  require("lspcfg")
  Statuline = require("stlcfg").statusline
  vim.api.nvim_set_option_value('statusline', '%!v:lua.Statuline()', { scope = 'global' })
end

-- User defined functions
function InsertLastUpdate()
  -- Timestamp
  local lu = "Last update: " .. os.date("%Y/%m/%d[%H:%M]")
  local line = vim.fn.line(".")
  if line then
    -- Use 'if' function to avoid nil value.
    vim.fn.append(line, lu)
  end
end

vim.keymap.set('n', '<F5>', InsertLastUpdate)

vim.keymap.set('n', '<Leader>st', function()
  vim.wo.scrolloff = 999
end)
vim.keymap.set('n', '<Leader>sf', function()
  vim.wo.scrolloff = 0
end)

vim.api.nvim_create_user_command("ConvTohten", function()
  vim.cmd(":%s/．/。/g")
  vim.cmd(":%s/，/、/g")
end, { desc = "Convert from \"．，\" to \"。、\"." })
