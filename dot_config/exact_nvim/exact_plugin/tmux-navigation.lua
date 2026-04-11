vim.pack.add({ 'https://github.com/christoomey/vim-tmux-navigator' })

vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', { desc = 'Navigate left' })
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', { desc = 'Navigate down' })
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', { desc = 'Navigate up' })
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>', { desc = 'Navigate right' })
vim.keymap.set('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<CR>', { desc = 'Navigate to previous pane' })
