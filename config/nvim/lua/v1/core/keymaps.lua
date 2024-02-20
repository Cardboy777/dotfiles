vim.keymap.set('n', '<leader>ga', function()
  vim.cmd('git add *')
end, { desc = '[G]it [A]dd' })

vim.keymap.set('n', '<leader>gp', function() end, { desc = '[G]it [P]ush' })

-- Make Deleting actually delete
vim.keymap.set('n', 'd', '"_dd', { desc = 'Delete Line' })
vim.keymap.set('v', 'd', '"_d', { desc = 'Delete Selected Text' })
-- Make cut behave like default delete
vim.keymap.set('n', 'c', 'dd', { desc = 'Cut line' })
vim.keymap.set('v', 'c', 'd', { desc = 'Cut Selected Text' })

vim.keymap.set('v', '<tab>', '>', { desc = 'Cut Selected Text' })
vim.keymap.set('v', '<S-tab>', '<', { desc = 'Cut Selected Text' })
