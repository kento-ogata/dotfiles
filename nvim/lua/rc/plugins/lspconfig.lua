local M = {}

M.setup = function()
  local lspconfig = require('lspconfig')
  lspconfig.omnisharp.setup {}
  lspconfig.dockerls.setup {}
  lspconfig.yamlls.setup {}
  lspconfig.sumneko_lua.setup {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
  lspconfig.vimls.setup {}
  lspconfig.denols.setup {}
end

return M
