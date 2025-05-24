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
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle focus=false<cr>')
vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle pinned=true win.relative=win win.position=right<cr>')

-- Choose window
vim.keymap.set('n', '-', '<cmd>ChooseWin<cr>')

-- Show TODO in telescope
vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>')

-- Copy to system
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y')
vim.keymap.set({'n', 'v'}, '<leader>yy', '"+yy')
