return {
  'folke/tokyonight.nvim',
  opts = {},
  config = function()
    require('tokyonight').setup({
      style = 'moon',
      transparent = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = { italic = false, underline = false },
        variables = { italic = false, underline = false },
      },
      lualine_bold = true,
      on_colors = function()
        -- Do nothing
      end,
      on_highlights = function()
        -- Do nothing
      end,
    })
    vim.cmd([[colorscheme tokyonight-moon]])
  end,
}
