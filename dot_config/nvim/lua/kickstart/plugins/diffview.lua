return {
  'sindrets/diffview.nvim',
  opts = {
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        layout = 'diff4_mixed',
        disable_diagnostics = true,
      },
      default = {
        winbar_info = true, -- small labels for LOCAL/REMOTE/BASE
      },
    },
    hooks = {
      file_panel_closed = function()
        vim.cmd 'wincmd =' -- equalize windows after closing file panel
      end,
    },
  },
  keys = {
    {
      '<leader>gd',
      function()
        vim.cmd 'DiffviewOpen'
        vim.cmd 'DiffviewToggleFiles' -- start without file panel
        vim.cmd 'wincmd =' -- equalize windows
      end,
      desc = 'Open Diffview (no file panel)',
    },
    { '<leader>gD', '<cmd>DiffviewClose<CR>', desc = 'Close Diffview' },
    {
      '<leader>gt',
      function()
        vim.cmd 'DiffviewToggleFiles'
        vim.cmd 'wincmd =' -- equalize windows after toggling
      end,
      desc = 'Toggle Diffview Files',
    },
  },
}
