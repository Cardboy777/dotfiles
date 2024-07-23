---- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })

require('v1/core/setup')
require('v1/lsp/config')

require('telescope').load_extension('harpoon')
