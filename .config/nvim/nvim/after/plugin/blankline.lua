vim.opt.list = true
vim.opt.listchars:append "space:⋅"

vim.cmd [[highlight IndentBlanklineChar guifg=#504945 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar guifg=#458588 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineSpaceChar guifg=#504945 gui=nocombine]]

require('indent_blankline').setup({
  show_end_of_line = true,
  show_current_context = true,
  space_char_blankline = " ",
})
