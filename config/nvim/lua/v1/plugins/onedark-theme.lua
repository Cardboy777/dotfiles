return {
  'navarasu/onedark.nvim',
  config = function()
    local onedark = require('onedark')

    onedark.setup({
      style = 'deep',
      transparent = true,
      ending_tildes = false,
      lualine = {
        transparent = true,
      },
    })
    onedark.load()
  end,
}
