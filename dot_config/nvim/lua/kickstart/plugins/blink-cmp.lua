return {
  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      { 'L3MON4D3/LuaSnip', version = '2.*', build = 'make install_jsregexp', opts = {} },
      'folke/lazydev.nvim',
      { 'kristijanhusak/vim-dadbod-completion' },
    },

    opts = {
      keymap = { preset = 'default' },
      appearance = { nerd_font_variant = 'mono' },

      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
        menu = {
          border = 'rounded',
          winblend = 0,
          winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder',
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'dadbod' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
          dadbod = {
            name = 'Dadbod',
            module = 'vim_dadbod_completion.blink',
            score_offset = 75,
            enabled = function()
              local ft = vim.bo.filetype
              return ft == 'sql' or ft == 'mysql' or ft == 'plsql'
            end,
          },
        },
      },

      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'lua' },

      signature = {
        enabled = true,
        window = {
          border = 'rounded',
          winblend = 0,
          winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
        },
      },
    },

    config = function(_, opts)
      require('blink.cmp').setup(opts)

      -- Signature window bg/border
      vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelp', { fg = '#808080', bg = vim.fn.synIDattr(vim.fn.hlID 'Normal', 'guibg') })
      vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelpBorder', { link = 'Normal' })

      -- -- Active parameter = keep it colorful / normal text
      -- vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelpActiveParameter', { link = 'Normal' })
      -- vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelpInactiveParameter', { link = 'Comment' })

      -- Completion menu
      vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { link = 'Normal' })
      vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { link = 'Normal' })
    end,
  },
}
