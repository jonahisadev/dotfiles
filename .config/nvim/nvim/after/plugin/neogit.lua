require('neogit').setup({})

vim.api.nvim_create_autocmd('User', {
  pattern = 'NeogitPushComplete',
  callback = function() require('notify')('Push complete') end
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'NeogitPullComplete',
  callback = function() require('notify')('Pull complete') end
})
