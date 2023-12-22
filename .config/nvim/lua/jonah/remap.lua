vim.g.mapleader = ";"

-- Neotree
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>')

-- Format file
vim.keymap.set('n', '<leader>sf', function()
  vim.lsp.buf.format()
end)

-- Quit / Macro
vim.keymap.set('n', 'Q', 'q')
vim.keymap.set('n', 'gQ', '@q')
vim.keymap.set('n', 'q', '<cmd>quit<cr>')

-- Braces
vim.keymap.set('n', '<leader>wr', '<cmd>Brace<cr>')

-- Reselect blocks after indentation
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv|')

-- Show issues
vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>')

-- Choose window
vim.keymap.set('n', '-', '<Plug>(choosewin)')

-- Show TODO in telescope
vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>')

-- Code Actions
vim.keymap.set('n', '<leader>ll', function()
  vim.lsp.buf.code_action()
end)
