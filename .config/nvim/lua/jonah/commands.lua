-- Create braces around a specific range or current line
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function(ev)
    vim.api.nvim_buf_create_user_command(
      0,
      'Brace',
      function(opts)

        -- Setup
        local firstLine = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line1, false)[1]
        local spaces = ""

        -- Find indentation
        for i = 1, #firstLine do
          if firstLine:sub(i,i) == " " then
            spaces = spaces .. " "
          else
            break
          end
        end

        -- Insert braces
        vim.api.nvim_buf_set_lines(0, opts.line1 - 1, opts.line1 - 1, false, {spaces .. '{'})
        vim.api.nvim_buf_set_lines(0, opts.line2 + 1, opts.line2 + 1, false, {spaces .. '}'})

        -- Indent
        for i = opts.line1 + 1, opts.line2 + 1, 1 do
          vim.fn.cursor(i, 1)
          vim.cmd('normal! >>')
        end

        -- Go back to the start
        vim.fn.cursor(opts.line1, string.len(spaces) + 1)
      end,
      { nargs = 0, range = true }
    )
  end
})

-- Complete a task
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { "*.md", "*.txt" },
  callback = function(ev)
    vim.api.nvim_buf_create_user_command(
      0,
      'TaskComplete',
      function(opts)
        local line = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line1, false)[1]
        local idx = string.find(line, '%[ %]')

        -- Check off item
        vim.api.nvim_buf_set_text(0, opts.line1 - 1, idx, opts.line1 - 1, idx + 1, {'x'})

        -- Place completed at the end
        local timeFmt = os.date("%b %d, %Y - %I:%M %p")
        vim.api.nvim_buf_set_text(
          0,
          opts.line1 - 1,
          string.len(line),
          opts.line1 - 1,
          string.len(line),
          { '\t\t@completed(' .. timeFmt .. ')' }
        )
      end,
      { nargs = 0, range = true }
    )
  end
})

-- Open PlantUML image
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { "*.puml", "*.plantuml" },
  callback = function(ev)
    vim.api.nvim_buf_create_user_command(
      0,
      'PlantOpen',
      function(opts)
        local path = ev.file
        local filename, _ = path:match("^.+/(.+)%.(.+)$")
        vim.fn.jobstart('imv ' .. filename .. '.png')
      end,
      { nargs = 0 }
    )
  end
})
