-- document existing key chains
require('which-key').add({
  { '<leader>c', name = 'Code' },
  { '<leader>d', name = 'Document' },
  { '<leader>g', name = 'Git' },
  { '<leader>h', name = 'More git' },
  { '<leader>r', name = 'Rename' },
  { '<leader>s', name = 'Search' },
  { '<leader>w', name = 'Workspace' },
})

require('v1/lsp/treesitter')
require('v1/lsp/completions')
require('v1/lsp/server_setup')
