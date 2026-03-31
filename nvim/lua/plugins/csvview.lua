local env = require("envcfg")

return {
  "hat0uma/csvview.nvim",
  enabled = env.use_extra,
  ft = "csv",
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        if args.match == "csv" then
          vim.cmd("CsvViewEnable")
        end
      end,
      group = vim.api.nvim_create_augroup("CSVInitialize", { clear = true }),
    })
  end,
  opts = {
    parser = {
      async_chunksize = 50,
    },
    view = {
      min_column_width = 5,
      spacing = 2,
    },
  },
}
