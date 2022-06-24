local M = {}

M.setup = function()
  require 'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
      disable = { "help" },
    },
    indent = {
      enable = true,
      disable = { "yaml" },
    },
  }
end

return M
