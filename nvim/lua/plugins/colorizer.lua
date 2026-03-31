local env = require("envcfg")

return {
  "norcalli/nvim-colorizer.lua",
  enabled = env.use_extra,
  cmd = {
    "ColorizerAttachToBuffer",
    "ColorizerReloadAllBuffer",
    "ColorizerToggle",
  },
  opts = {},
}
