return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    event = 'VimEnter',
    dependencies = {
      'rafamadriz/friendly-snippets',
      { 'L3MON4D3/LuaSnip', version = '2.*', build = 'make install_jsregexp' },
      { 'folke/lazydev.nvim', opts = {} },
      { 'kristijanhusak/vim-dadbod-completion' },
    },

    opts = {
      -- Appearance
      appearance = {
        nerd_font_variant = 'mono',
        use_nvim_cmp_as_default = true,
      },

      -- Mappings
      keymap = {
        preset = 'default',
        ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },

      completion = {
        -- 'prefix' matches usually feel cleaner than 'exact'
        keyword = { range = 'prefix' },

        documentation = {
          auto_show = false, -- FIXED: This disables the "new box" from popping up
          auto_show_delay_ms = 500,
        },

        -- Reduces "bloat" by not showing menu on special chars like '(', '.', etc.
        trigger = {
          show_on_insert_on_trigger_character = false,
        },

        menu = {
          border = 'rounded',
          winblend = 0,
          winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder',
        },
      },

      -- Sources
      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'dadbod', 'buffer' },
        providers = {
          lsp = {
            -- KEY CHANGE: Menu only appears after 3 characters are typed.
            -- This acts as your "delay" prevents the menu from flashing on every keystroke.
            min_keyword_length = 3,
            score_offset = 0,
          },
          path = {
            min_keyword_length = 0,
          },
          snippets = {
            min_keyword_length = 2,
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
          dadbod = {
            name = 'Dadbod',
            module = 'vim_dadbod_completion.blink',
            score_offset = 75,
            enabled = function()
              return vim.tbl_contains({ 'sql', 'mysql', 'plsql' }, vim.bo.filetype)
            end,
          },
        },
      },

      snippets = { preset = 'luasnip' },

      signature = {
        enabled = true,
        trigger = {
          show_on_insert = false,
          show_on_trigger_character = false,
        },
        window = {
          border = 'rounded',
          winblend = 0,
          winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
        },
      },
    },

    -- Highlights
    config = function(_, opts)
      require('blink.cmp').setup(opts)
      local set_hl = vim.api.nvim_set_hl
      set_hl(0, 'BlinkCmpSignatureHelp', { fg = '#808080', bg = vim.fn.synIDattr(vim.fn.hlID('Normal'), 'guibg') })
      set_hl(0, 'BlinkCmpSignatureHelpBorder', { link = 'Normal' })
      set_hl(0, 'BlinkCmpMenu', { link = 'Normal' })
      set_hl(0, 'BlinkCmpMenuBorder', { link = 'Normal' })
    end,
  },
}
