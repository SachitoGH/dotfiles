vim.pack.add({ 'https://github.com/ibhagwan/fzf-lua' })

require('fzf-lua').setup {
  'default-title',
  fzf_opts = { ['--layout'] = 'reverse' },
  winopts = {
    border = 'rounded',
    preview = { layout = 'vertical', vertical = 'down:50%' },
  },
}

-- Register as vim.ui.select handler (replaces telescope-ui-select)
require('fzf-lua').register_ui_select()

local fzf = require 'fzf-lua'
vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = 'Search help tags' })
vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = 'Search keymaps' })
vim.keymap.set('n', '<leader>sf', fzf.files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>ss', fzf.builtin, { desc = 'Browse fzf-lua pickers' })
vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = 'Search word under cursor' })
vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = 'Search diagnostics' })
vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = 'Resume last search' })
vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = 'Search recent files' })
vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = 'Switch buffer' })

vim.keymap.set('n', '<leader>/', fzf.blines, { desc = 'Fuzzy search in buffer' })

vim.keymap.set('n', '<leader>s/', function()
  fzf.live_grep { grep_open_files = true }
end, { desc = 'Live grep in open files' })

vim.keymap.set('n', '<leader>sn', function()
  fzf.files { cwd = vim.fn.stdpath 'config' }
end, { desc = 'Search neovim config' })
