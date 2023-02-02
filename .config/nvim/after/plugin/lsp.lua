local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed {
  'tsserver',
  'eslint',
  'sumneko_lua',
  'rust_analyzer',
  'clangd'
}

local cmp = require('cmp')
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<CR>'] = cmp.mapping.confirm({ select = true })
})
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  sign_icons = {}
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', '<leader>sd', function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set('n', '<leader>sr', function() vim.lsp.buf.rename() end, opts)
end)

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
