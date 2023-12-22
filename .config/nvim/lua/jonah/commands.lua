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

