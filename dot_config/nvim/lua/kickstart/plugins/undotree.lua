return {
  'mbbill/undotree',
  cmd = 'UndotreeToggle', -- lazy-load it with this command
  keys = {
    { '<leader>u', '<cmd>UndotreeToggle<CR>', desc = 'Toggle undo tree' },
  },
  config = function()
    -- Optional: Configure undotree
    vim.g.undotree_HighlightChangedText = 1 -- Highlight changed text in the preview
    vim.g.undotree_ShortCut = 't' -- Change navigation key from 'n'/'p' to 't' for example
    -- See :h undotree-options for more
  end,
}
