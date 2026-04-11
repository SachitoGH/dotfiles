-- Built-in undotree (Neovim 0.12)
vim.api.nvim_create_user_command('UndotreeToggle', function()
  vim.cmd.packadd('nvim.undotree')
  vim.cmd.Undotree()
end, { desc = 'Toggle undo tree' })

vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Toggle undo tree' })
