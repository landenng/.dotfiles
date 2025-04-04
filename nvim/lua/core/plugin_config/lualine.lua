require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark_vivid',
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
