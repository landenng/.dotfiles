require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'catppuccin-macchiato',
  },
  sections = {
    lualine_a = {
      {
        'buffers',
        path = 1,
      }
    }
  }
}
