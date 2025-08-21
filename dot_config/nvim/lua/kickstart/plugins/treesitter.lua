return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'css',
        'javascript',
        'typescript',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'python',
        'sql',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },

      -- Disable conflicting textobject select module
      textobjects = {
        select = {
          enable = false,
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>ap'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>aP'] = '@parameter.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']]'] = '@function.outer',
            [']c'] = '@class.outer',
            [']i'] = '@conditional.outer',
            [']l'] = '@loop.outer',
          },
          goto_next_end = {
            [']['] = '@function.outer',
            [']C'] = '@class.outer',
            [']I'] = '@conditional.outer',
            [']L'] = '@loop.outer',
          },
          goto_previous_start = {
            ['[['] = '@function.outer',
            ['[c'] = '@class.outer',
            ['[i'] = '@conditional.outer',
            ['[l'] = '@loop.outer',
          },
          goto_previous_end = {
            ['[]'] = '@function.outer',
            ['[C'] = '@class.outer',
            ['[I'] = '@conditional.outer',
            ['[L'] = '@loop.outer',
          },
        },
      },
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
    },
  },
}
