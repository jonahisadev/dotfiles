-- Basic vim options
vim.opt.number = true               -- Show line numbers
vim.opt.wrap = false                -- Don't wrap lines
vim.opt.swapfile = false            -- Don't save swap files
vim.opt.signcolumn = "yes"          -- Always show the sign column
vim.opt.winborder = "rounded"       -- Rounded window borders
vim.opt.tabstop = 2                 -- Number of spaces tabs count for
vim.opt.shiftwidth = 2              -- Size of an indent
vim.opt.expandtab = true            -- Use spaces instead of tabs
vim.opt.smartindent = true          -- Autoindent new lines
vim.opt.scrolloff = 8               -- Minimum lines to keep above and below the cursor
vim.opt.colorcolumn = "80"          -- Line length marker at 80 characters
vim.opt.list = true                 -- Show whitespace characters
vim.opt.listchars:append "space:⋅"  -- Show spaces as dots
vim.opt.showtabline = 2             -- Always show the tab line
vim.g.mapleader = ';'               -- Set leader key to ; (e.g. ;ff to find files)

-- Keymaps
vim.keymap.set('n', 'Q', 'q')       -- Remap Q to q to avoid accidental Ex mode
vim.keymap.set('n', 'gQ', '@q')     -- gQ to record macros to q register
vim.keymap.set('n', 'q', ':quit<CR>') -- Just press 'q' to quit
vim.keymap.set('x', '<', '<gv')     -- Stay in indent mode when indenting
vim.keymap.set('x', '>', '>gv|')    -- Stay in indent mode when indenting
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y') -- Yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>yy', '"+yy') -- Yank line to system clipboard
vim.keymap.set('n', '<leader>ff', ':Pick files<CR>') -- File picker
vim.keymap.set('n', '<leader>fg', ':Pick grep_live<CR>') -- Live grep
vim.keymap.set('n', '<leader>fb', ':Pick buffers<CR>')  -- Buffer picker

-- LSP keymaps
--
-- Format document
vim.keymap.set('n', '<leader>sf', vim.lsp.buf.format)
-- Go to definition
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
-- Hover for info
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
-- Rename symbol
vim.keymap.set('n', '<leader>sr', vim.lsp.buf.rename)

-- Packages
vim.pack.add({
  -- Core plugins
  { src = "https://github.com/stevearc/oil.nvim" },        -- File explorer
  { src = "https://github.com/neovim/nvim-lspconfig" },   -- LSP configurations
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" }, -- Syntax highlighting
  { src = "https://github.com/hrsh7th/nvim-cmp" },        -- Autocompletion
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },    -- LSP source for nvim-cmp
  { src = "https://github.com/github/copilot.vim" },      -- GitHub Copilot

  -- Theme
  { src = "https://github.com/catppuccin/nvim" },         -- Color theme

  -- mini.nvim
  { src = "https://github.com/echasnovski/mini.pick" },   -- Fuzzy finder
  { src = "https://github.com/echasnovski/mini.icons" },  -- Icons
  { src = "https://github.com/echasnovski/mini.snippets" }, -- Snippets
  { src = "https://github.com/echasnovski/mini.statusline" }, -- Statusline
  { src = "https://github.com/echasnovski/mini.sessions" }, -- Session management
  { src = "https://github.com/echasnovski/mini.extra" },  -- Extra utilities

  -- QoL plugins
  { src = "https://github.com/lewis6991/gitsigns.nvim" }, -- Git integration
  { src = "https://github.com/cohama/lexima.vim" },       -- Auto pairs (quotes, parentheses, etc.)
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

-- Symbol search
vim.keymap.set('n', '<leader>fs', ":Pick lsp scope='document_symbol'<CR>")

-- Diagnostics
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

-- Create session file
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
