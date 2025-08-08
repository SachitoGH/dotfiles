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
      completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'dadbod' },
        providers = {
          lazydev = {
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
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
      signature = { enabled = true },
    },
  },
}
