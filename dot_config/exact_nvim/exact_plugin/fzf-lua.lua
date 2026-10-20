-- WSL: XDG_RUNTIME_DIR may not exist; fall back to a writable temp path
if not vim.env.XDG_RUNTIME_DIR or vim.fn.isdirectory(vim.env.XDG_RUNTIME_DIR) == 0 or vim.fn.filewritable(vim.env.XDG_RUNTIME_DIR) ~= 2 then
  vim.env.XDG_RUNTIME_DIR = vim.fn.stdpath 'cache'
end

local pick = require 'pick'

-- Register fzf-lua as the vim.ui.select handler on first use (replaces telescope-ui-select)
vim.ui.select = function(...)
  pick 'register_ui_select'()
  return vim.ui.select(...)
end

vim.keymap.set('n', '<leader>sh', pick 'helptags', { desc = 'Search help tags' })
vim.keymap.set('n', '<leader>sk', pick 'keymaps', { desc = 'Search keymaps' })
vim.keymap.set('n', '<leader>sf', pick 'files', { desc = 'Search files' })
vim.keymap.set('n', '<leader>ss', pick 'builtin', { desc = 'Browse fzf-lua pickers' })
vim.keymap.set('n', '<leader>sw', pick 'grep_cword', { desc = 'Search word under cursor' })
vim.keymap.set('n', '<leader>sg', pick 'live_grep', { desc = 'Live grep' })
vim.keymap.set('n', '<leader>sd', pick 'diagnostics_document', { desc = 'Search diagnostics' })
vim.keymap.set('n', '<leader>sr', pick 'resume', { desc = 'Resume last search' })
vim.keymap.set('n', '<leader>s.', pick 'oldfiles', { desc = 'Search recent files' })
vim.keymap.set('n', '<leader><leader>', pick 'buffers', { desc = 'Switch buffer' })

vim.keymap.set('n', '<leader>/', pick 'blines', { desc = 'Fuzzy search in buffer' })

vim.keymap.set('n', '<leader>s/', pick('live_grep', { grep_open_files = true }), { desc = 'Live grep in open files' })

vim.keymap.set('n', '<leader>sn', function()
  pick('files', { cwd = vim.fn.stdpath 'config' })()
end, { desc = 'Search neovim config' })
