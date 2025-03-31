local lsp = require('lsp-zero')

lsp.preset('recommended')

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'eslint', 'rust_analyzer', 'clangd', 'phpactor' },
  handlers = {
    lsp.default_setup
  }
})

local cmp = require('cmp')
local cmp_action = lsp.cmp_action()
cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  }),
  sources = {
    { name = 'nvim_lsp' }
  }
})

lsp.set_preferences({
  sign_icons = {}
})

function on_attach(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set('n', '<leader>gd', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', '<leader>sd', function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set('n', '<leader>sr', function() vim.lsp.buf.rename() end, opts)
end

lsp.on_attach(on_attach)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = {
      spacing = 4,
      prefix = '●'
    },
    signs = true
  }
)

lsp.setup()

require('lspconfig').phpactor.setup({
  on_attach = on_attach,
  init_options = {
    ["language_server_phpstan.enabled"] = true
  }
})
