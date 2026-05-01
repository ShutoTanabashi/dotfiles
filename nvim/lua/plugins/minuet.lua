local env = require("envcfg")
local llm = env.llm

return {
  "milanglacier/minuet-ai.nvim",
  enabled = not vim.g.vscode and llm.enabled,
  config = function()
    require("minuet").setup({
      provider = "openai_compatible",
      request_timeout = 2.5,
      throttle = 2000,
      debounce = 800,
      provider_options = {
        openai_compatible = {
          api_key = llm.api_key_env,
          end_point = llm.end_point,
          model = llm.model,
          name = llm.provider_name,
          optional = {
            max_tokens = 56,
            top_p = 0.9,
            thinking = { type = "disabled" },
          },
        },
      },
    })
  end,
}
