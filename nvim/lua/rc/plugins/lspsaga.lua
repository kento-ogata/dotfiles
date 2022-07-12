local M = {}

M.setup = function()
  local saga = require 'lspsaga'

  -- use default config
  saga.init_lsp_saga()
end

return M
