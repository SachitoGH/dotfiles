return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration
    'nvim-telescope/telescope.nvim', -- optional
  },
  keys = {
    {
      '<leader>gg',
      function()
        require('neogit').open()
      end,
      desc = 'Open Neogit',
    },
    {
      '<leader>gc',
      function()
        require('neogit').open { 'commit' }
      end,
      desc = 'Neogit Commit',
    },
    {
      '<leader>gp',
      function()
        require('neogit').open { 'pull' }
      end,
      desc = 'Neogit Pull',
    },
    {
      '<leader>gP',
      function()
        require('neogit').open { 'push' }
      end,
      desc = 'Neogit Push',
    },
  },
}
