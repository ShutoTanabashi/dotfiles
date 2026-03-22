-- Settings for windows
local M = {}

function M.apply_to(config)
  config.default_prog = { 'pwsh.exe', '-NoLogo' }
end

return M
