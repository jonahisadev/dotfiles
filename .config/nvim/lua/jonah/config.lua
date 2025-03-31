-- Tab width
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Line numbers
vim.opt.number = true
vim.opt.scrolloff = 8;

-- Better colors
vim.opt.termguicolors = true

-- Misc
vim.opt.wrap = false
vim.opt.colorcolumn = "80"
vim.opt.updatetime = 50

-- Better popup options
vim.opt.pumheight = 16

-- Auto prettier
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = {"*.js", "*.ts", "*.tsx", "*.jsx", "*.vue"},
  callback = function(ev)
    vim.cmd("Neoformat")
  end
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = {"*.cpp", "*.hpp", "*.c", "*.h", "*.rs"},
  callback = function(ev)
    vim.lsp.buf.format()
  end
})

-- Auto PlantUML
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.puml", "*.plantuml" },
  callback = function(ev)
    vim.fn.jobstart('plantuml ' .. ev.file)
  end
})

-- Highlight yanks
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  command = 'silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}'
})

-- Better letters for choosewin
vim.g.choosewin_label = 'ADWBCEFGHIJKLMNOPQRTUVYZ'

-- Prisma needs to load the right thing for treesitter
vim.filetype.add({
  pattern = {
    ['*.prisma'] = 'prisma'
  }
})
