-- Basic vim options
vim.opt.number = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.showtabline = 2
vim.g.mapleader = ';'

-- Keymaps
vim.keymap.set('n', 'Q', 'q')
vim.keymap.set('n', 'gQ', '@q')
vim.keymap.set('n', 'q', ':quit<CR>')
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv|')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>yy', '"+yy')
vim.keymap.set('n', '<leader>ff', ':Pick files<CR>')
vim.keymap.set('n', '<leader>fg', ':Pick grep_live<CR>')
vim.keymap.set('n', '<leader>fb', ':Pick buffers<CR>')

vim.keymap.set('n', '<leader>sf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>sd', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>sr', vim.lsp.buf.rename)

-- Packages
vim.pack.add({
  -- Core plugins
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/github/copilot.vim" },

  -- Theme
  { src = "https://github.com/catppuccin/nvim" },

  -- mini.nvim
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/echasnovski/mini.icons" },
  { src = "https://github.com/echasnovski/mini.snippets" },
  { src = "https://github.com/echasnovski/mini.statusline" },
  { src = "https://github.com/echasnovski/mini.sessions" },
  { src = "https://github.com/echasnovski/mini.extra" },

  -- QoL plugins
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/cohama/lexima.vim" },
})

-- Oil
require('oil').setup({
  default_file_explorer = true,
  keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = "actions.select",
    ["t"] = { "actions.select", opts = { tab = true } },
    ["<C-p>"] = "actions.preview",
    ["<ESC>"] = { "actions.close", mode = "n" },
    ["<C-r>"] = "actions.refresh",
    ["<BS>"] = { "actions.parent", mode = "n" },
    ["g."] = { "actions.toggle_hidden", mode = "n" },
  },
  float = {
    max_width = 0.5,
    max_height = 0.5,
    get_win_title = function() return " File Browser " end
  }
})
vim.keymap.set('n', '<leader>e', require('oil').open_float)

-- mini.nvim
require('mini.pick').setup()
require('mini.icons').setup()
require('mini.snippets').setup()
require('mini.statusline').setup()
require('mini.sessions').setup({
  autoread = true,
  file = '.session.vim'
})
require('mini.extra').setup()

vim.keymap.set('n', '<leader>fs', ":Pick lsp scope='document_symbol'<CR>")
vim.keymap.set('n', '<leader>xx', function()
  MiniExtra.pickers.diagnostic(nil, {
    window = {
      config = {
        anchor = "SW",
        height = math.floor(vim.o.lines * 0.75),
        width = math.floor(vim.o.columns * 0.9),
      }
    }
  })
end)
vim.keymap.set('n', '<leader>mms', function()
  MiniSessions.write('.session.vim')
end)

-- LSP
vim.lsp.enable({ "lua_ls", "ts_ls", "rust_analyzer", "gopls" })
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
      insert({ body = args.body })
      cmp.resubscribe({ "TextChangedI", "TextChangedP" })
      require("cmp.config").set_onetime({ sources = {} })
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" }
  })
})

-- Colorscheme
require('catppuccin').setup({
  flavour = "mocha",
  background = {
    dark = "mocha"
  },
  default_integrations = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    mini = {
      enabled = true
    }
  }
})
vim.cmd("colorscheme catppuccin")
vim.cmd([[highlight IndentBlanklineChar guifg=#504945 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineContextChar guifg=#458588 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineSpaceChar guifg=#504945 gui=nocombine]])

-- Format on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function(_ev)
    vim.lsp.buf.format({ async = true })
  end
})

-- Highlight yanks
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  command = 'silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}'
})
