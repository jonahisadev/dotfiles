require('window-picker').setup({
  hint = "floating-big-letter",
  selection_chars = 'ADSBCEFGHIJKLMNOPQRTUVWXYZ1234567890',
  picker_config = {
    floating_big_letter = {
      font = 'ansi-shadow',
    },
  },
  show_prompt = false,
  filter_rules = {
    autoselect_one = false,
    include_current_win = true,
    include_unfocusable_windows = true,

    -- These options will be ignored if the buffer is listed in
    bo = {
        filetype = { 'notify', 'snacks_notif' },
        buftype = { 'terminal' },
    }
  }
})
