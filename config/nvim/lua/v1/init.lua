---- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('v1/core/plugin-manager')
require('v1/core/options')
require('v1/core/keymaps')
require('v1/core/telescope')

require('v1/lsp/treesitter')
require('v1/lsp/config')
require('v1/lsp/completions')

require('telescope').load_extension('harpoon')

require('bufferline').setup()

-- add Copilot symbol to copilot-cmp suggesttions
require('lspkind').init({
  symbol_map = {
    Copilot = '',
  },
})

vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })

-- Harpoon keymaps via Primagen
-- vim.keymap.set('n', '<leader>a', require('harpoon.mark').addfile, { desc = '[A]dd File' })
-- vim.keymap.set('n', '<C-e>', require('harpoon.ui').toggle_quick_menu, { desc = '[E]xplore Harpoon Files' })

-- vim.keymap.set('n', '<C-h>', function() require('harpoon.ui').nav_file(1) end, { desc = 'Harpoon File 1' })
-- vim.keymap.set('n', '<C-t>', function() require('harpoon.ui').nav_file(2) end, { desc = 'Harpoon File 2' })
-- vim.keymap.set('n', '<C-n>', function() require('harpoon.ui').nav_file(3) end, { desc = 'Harpoon File 3' })
-- vim.keymap.set('n', '<C-s>', function() require('harpoon.ui').nav_file(4) end, { desc = 'Harpoon File 4' })
