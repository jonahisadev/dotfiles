vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Color theme
  -- use('ellisonleao/gruvbox.nvim')
  use({ 'catppuccin/nvim', as = 'catppuccin' })

  -- Syntax highlighting
  use('nvim-treesitter/nvim-treesitter', {run = 'TSUpdate'})
  use('nvim-treesitter/playground')

  -- File tree
  use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }

  -- Choose window
  use('t9md/vim-choosewin')

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

  -- Get eslint to work with LSP
  use('jose-elias-alvarez/null-ls.nvim')

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Auto Pair
  use {
    "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
  }

  -- Persist sessions
  use({
    "olimorris/persisted.nvim",
    --module = "persisted", -- For lazy loading
    config = function()
      require("persisted").setup()
      require("telescope").load_extension("persisted") -- To load the telescope extension
    end,
  })

  -- Better LSP Diagnostics
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }

  -- Commenting
  use('numToStr/Comment.nvim')

  -- Formatting
  use('sbdchd/neoformat')

  -- Line indentation
  use({
    'lukas-reineke/indent-blankline.nvim',
    tag = 'v2.20.8'
  })

  -- Notifications
  use('rcarriga/nvim-notify')

  -- Git
  use({
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  })
  use({
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
  })

  -- Search highlighting
  use('romainl/vim-cool')

  -- Till highlighting
  use('deris/vim-shot-f')

  -- Todo highlighting
  use({
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
  })

  -- Java Language Server
  use 'mfussenegger/nvim-jdtls'
end)
