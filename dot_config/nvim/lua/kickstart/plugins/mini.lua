return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local ai = require 'mini.ai'
      ai.setup {
        n_lines = 500,
        custom_textobjects = {
          -- Treesitter-powered textobjects
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
          p = ai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }, {}),
          d = ai.gen_spec.treesitter({ a = '@conditional.outer', i = '@conditional.inner' }, {}),
          l = ai.gen_spec.treesitter({ a = '@loop.outer', i = '@loop.inner' }, {}),
          a = ai.gen_spec.treesitter({ a = '@assignment.outer', i = '@assignment.inner' }, {}),
        },
      }

      require('mini.surround').setup {
        mappings = {
          add = 'sa',
          delete = 'sd',
          find = 'sf',
          find_left = 'sF',
          highlight = 'sh',
          replace = 'sr',
          update_n_lines = 'sn',
        },
      }
      require('mini.move').setup {
        mappings = {
          left = 'H',
          right = 'L',
          up = 'K',
          down = 'J',
        },
      }

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      require('mini.icons').setup()
    end,
  },
}
