local M = {}

M.setup = function()
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "vim", "toml", "lua", "c_sharp", "bash", "fish" },
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
