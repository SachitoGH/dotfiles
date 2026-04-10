return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1

    -- Auto-resize DBUI query result window
    -- vim.api.nvim_create_autocmd('FileType', {
    --   pattern = 'dbout', -- DBUI query output buffer
    --   callback = function()
    --     vim.cmd 'resize 10' -- Set bottom buffer to 10 lines
    --   end,
    -- })
  end,
}
