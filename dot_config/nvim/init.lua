vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

require 'options'
require 'keymaps'
require 'lazy-bootstrap'
require 'lazy-plugins'

vim.cmd 'colorscheme carbonfox'

vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'none' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'none' })
vim.api.nvim_set_hl(0, 'MiniStatuslineInactive', { bg = 'none' })
vim.api.nvim_set_hl(0, 'MiniStatuslineDevinfo', { bg = 'none' })
vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { bg = 'none' })
vim.api.nvim_set_hl(0, 'MiniStatuslineFileinfo', { bg = 'none' })

vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { link = 'CursorLine' })

-- vim: ts=2 sts=2 sw=2 et
