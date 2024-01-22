vim.keymap.set('n', '<leader>ga', function()
  vim.cmd('git add *')
end, { desc = '[G]it [A]dd' })

vim.keymap.set('n', '<leader>gp', function() end, { desc = '[G]it [P]ush' })
