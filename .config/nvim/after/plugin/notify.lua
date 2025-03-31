local notify = require('notify')

notify.setup({
  background_colour = "#282828",
  max_width = math.floor(vim.o.columns / 2),
  stages = "fade",
  fps = 60
})

vim.notify = notify
