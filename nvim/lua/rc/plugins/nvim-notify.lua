local M = {}

M.setup = function()
  local notify = require('notify')
  notify.setup {}
  vim.notify = notify
end

return M
