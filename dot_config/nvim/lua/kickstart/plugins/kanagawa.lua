return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000, -- load first
    config = function()
      -- Optional setup
      require('kanagawa').setup {
        compile = false,
        undercurl = true,
        commentStyle = { italic = false },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        theme = 'wave', -- "wave", "dragon", "lotus"
        background = {
          dark = 'wave', -- try "dragon" for a darker variant
          light = 'lotus',
        },
      }

      -- Load the colorscheme
      vim.cmd 'colorscheme kanagawa-wave' -- or kanagawa-dragon / kanagawa-lotus
    end,
  },
}
