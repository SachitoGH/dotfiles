vim.pack.add({ 'https://github.com/christoomey/vim-tmux-navigator' })

vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', { desc = 'Navigate left (tmux/vim)' })
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', { desc = 'Navigate down (tmux/vim)' })
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', { desc = 'Navigate up (tmux/vim)' })
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>', { desc = 'Navigate right (tmux/vim)' })
vim.keymap.set('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<CR>', { desc = 'Navigate previous pane (tmux/vim)' })
