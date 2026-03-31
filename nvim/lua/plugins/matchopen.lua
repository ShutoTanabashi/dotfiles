local env = require("envcfg")

return {
  "arnar/vim-matchopen",
  enabled = env.use_extra,
  event = "VeryLazy",
}
