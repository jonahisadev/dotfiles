function ColorMyStuff(color)
  require('catppuccin').setup({
    background = {
      light = "latte",
      dark = "mocha"
    },
    transparent_background = true,
    show_end_of_buffer = true,
    integrations = {
      cmp = true,
      mason = true,
      neotree = true,
      treesitter = true,
      notify = true
    }
  })

  vim.cmd.colorscheme('catppuccin-mocha')
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyStuff()
