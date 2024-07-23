return {
  'folke/tokyonight.nvim',
  opts = {},
  -- dependencies = {
  --   {
  --     'HiPhish/rainbow-delimters.nvim',
  --     url = 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
  --     dependencies = { 'nvim-treesitter/nvim-treesitter' },
  --   },
  -- },
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

    -- local colors = require('tokyonight.colors').setup()
    --
    -- vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = colors.red })
    -- vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = colors.yellow })
    -- vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = colors.blue })
    -- vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = colors.orange })
    -- vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = colors.green })
    -- vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = colors.purple })
    -- vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = colors.cyan })
  end,
}
