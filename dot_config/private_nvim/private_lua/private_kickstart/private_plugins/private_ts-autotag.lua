return {
  'windwp/nvim-ts-autotag',
  ft = { 'html', 'javascript', 'typescript', 'xml', 'php', 'javascriptreact', 'typescriptreact' },
  config = function()
    require('nvim-ts-autotag').setup {
      -- You can add custom options here if needed
      -- For example, to disable specific languages:
      -- disable = { "javascript" }
    }
  end,
}
