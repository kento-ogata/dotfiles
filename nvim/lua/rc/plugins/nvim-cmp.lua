local M = {}

M.setup = function()
  local cmp = require('cmp')

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end
    },
    window = {
      completion = {
        -- border = 'single',
      },
      documentation = {
        -- border = 'single',
      },
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu', },
      format = require("lspkind").cmp_format({
        with_text = false,
      })
    },
    mapping = {
      ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i' }),
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i' }),
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'c' }),
      ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'c' }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<C-f>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp_signature_help' },
    }, {
      { name = 'path' },
    }, {
      { name = 'nvim_lsp' },
    }, {
      { name = 'calc' },
      { name = 'emoji' },
    }, {
      { name = 'buffer' },
    })
  })
  cmp.setup.filetype('gitcommit', {
    sources = require('cmp').config.sources({
      { name = 'cmp_git' },
    }, {
      { name = 'buffer' },
    })
  })
  require('cmp_git').setup({})
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' }
    }),
  })
end

return M
