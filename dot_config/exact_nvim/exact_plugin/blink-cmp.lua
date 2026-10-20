-- Completion is only needed once you type, so set it up after the first draw
require 'later'(function()
  require('blink.cmp').setup {
    -- Use Lua fuzzy matching on Termux (no pre-built Rust binary for Android/ARM64)
    fuzzy = {
      implementation = vim.fn.isdirectory '/data/data/com.termux' == 1 and 'lua' or 'prefer_rust',
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    keymap = {
      preset = 'default',
      ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },

    completion = {
      keyword = { range = 'prefix' },
      documentation = {
        auto_show = false,
        auto_show_delay_ms = 500,
      },
      trigger = {
        show_on_insert_on_trigger_character = false,
      },
      menu = {
        border = 'rounded',
        winblend = 0,
        winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder',
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
      providers = {
        lsp = {
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
      },
    },

    snippets = { preset = 'default' },

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
  }

  -- Highlights
  local set_hl = vim.api.nvim_set_hl
  local normal_bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
  local bg = normal_bg and string.format('#%06x', normal_bg) or 'NONE'
  set_hl(0, 'BlinkCmpSignatureHelp', { fg = '#808080', bg = bg })
  set_hl(0, 'BlinkCmpSignatureHelpBorder', { link = 'Normal' })
  set_hl(0, 'BlinkCmpMenu', { link = 'Normal' })
  set_hl(0, 'BlinkCmpMenuBorder', { link = 'Normal' })
end)
