function ColorMyStuff(color)
	require('gruvbox').setup({
		italic={
			strings=false,
			operators=false,
			comments=true
		},
    transparent_mode=true
	})

	color = color or 'gruvbox'
  vim.o.background = "dark"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyStuff()
