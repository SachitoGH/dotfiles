vim.pack.add({ 'https://github.com/sindrets/diffview.nvim' })

require('diffview').setup {
  enhanced_diff_hl = true,
  view = {
    merge_tool = {
      layout = 'diff4_mixed',
      disable_diagnostics = true,
    },
    default = {
      winbar_info = true,
    },
  },
  hooks = {
    file_panel_closed = function()
      vim.cmd 'wincmd ='
    end,
  },
}

vim.keymap.set('n', '<leader>gd', function()
  vim.cmd 'DiffviewOpen'
  vim.cmd 'DiffviewToggleFiles'
  vim.cmd 'wincmd ='
end, { desc = 'Git: Open diff view' })

vim.keymap.set('n', '<leader>gD', '<cmd>DiffviewClose<CR>', { desc = 'Git: Close diff view' })

vim.keymap.set('n', '<leader>gt', function()
  vim.cmd 'DiffviewToggleFiles'
  vim.cmd 'wincmd ='
end, { desc = 'Git: Toggle diff file panel' })
