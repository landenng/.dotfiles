require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'rose-pine',
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
