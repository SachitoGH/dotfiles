vim.pack.add({ 'https://github.com/EdenEast/nightfox.nvim' })

vim.cmd 'colorscheme carbonfox'

vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'none' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'none' })
vim.api.nvim_set_hl(0, 'MiniStatuslineInactive', { bg = 'none' })
vim.api.nvim_set_hl(0, 'MiniStatuslineDevinfo', { bg = 'none' })
vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { bg = 'none' })
vim.api.nvim_set_hl(0, 'MiniStatuslineFileinfo', { bg = 'none' })
vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { link = 'CursorLine' })
