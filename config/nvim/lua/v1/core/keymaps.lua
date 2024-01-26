vim.keymap.set('n', '<leader>ga', function()
  vim.cmd('git add *')
end, { desc = '[G]it [A]dd' })

vim.keymap.set('n', '<leader>gp', function() end, { desc = '[G]it [P]ush' })

-- Make Deleting actually delete
vim.keymap.set('n', 'd', '"_d', { desc = 'Delete [N]umber [D]irection' })
vim.keymap.set('n', 'dd', '"_dd', { desc = 'Delete line' })
vim.keymap.set('v', 'd', '"_d', { desc = 'Delete Selected Text' })
-- Make cut behave like default delete
vim.keymap.set('n', 'c', 'd', { desc = 'Cut [N]umber [D]irection' })
vim.keymap.set('n', 'cc', 'dd', { desc = 'Cut line' })
vim.keymap.set('v', 'c', 'd', { desc = 'Cut Selected Text' })
