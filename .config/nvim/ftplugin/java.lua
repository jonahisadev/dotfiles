local config = {
  cmd = { '/usr/bin/jdtls' },
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
}

local jdtls = require('jdtls')
jdtls.start_or_attach(config)

vim.keymap.set('n', '<leader>oi', function()
  jdtls.organize_imports()
end)

vim.keymap.set('n', '<leader>jvc', function()
  jdtls.compile("incremental")
end)
