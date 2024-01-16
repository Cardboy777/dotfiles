local OnBoardColors = {}

return {
  'brenoprata10/nvim-highlight-colors',
  config = function()
    require('nvim-highlight-colors').setup({
      custom_colors = {
        { label = '%-%-example%-color', color = '#10FF10' }, -- highlights 'var(--example-color)'
      },
    })
  end,
}
