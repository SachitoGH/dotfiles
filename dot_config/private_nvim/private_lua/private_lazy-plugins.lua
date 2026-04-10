require('lazy').setup({
  'NMAC427/guess-indent.nvim',

  require 'kickstart.plugins.treesitter-context',
  require 'kickstart.plugins.dial',
  require 'kickstart.plugins.copilot',
  require 'kickstart.plugins.gitsigns',
  require 'kickstart.plugins.carbonfox',
  -- require 'kickstart.plugins.which-key',
  require 'kickstart.plugins.telescope',
  require 'kickstart.plugins.lspconfig',
  require 'kickstart.plugins.blink-cmp',
  require 'kickstart.plugins.todo-comments',
  require 'kickstart.plugins.mini',
  require 'kickstart.plugins.treesitter',
  require 'kickstart.plugins.oil',
  require 'kickstart.plugins.tmux-navigation',
  require 'kickstart.plugins.undotree',
  require 'kickstart.plugins.diffview',
  require 'kickstart.plugins.flash',
  require 'kickstart.plugins.live-preview',
  require 'kickstart.plugins.ts-autotag',
  require 'kickstart.plugins.neoscroll',
  require 'kickstart.plugins.autopairs',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘', config = '🛠', event = '📅', ft = '📂', init = '⚙',
      keys = '🗝', plugin = '🔌', runtime = '💻', require = '🌙',
      source = '📄', start = '🚀', task = '📌', lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
