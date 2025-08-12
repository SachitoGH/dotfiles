return {
  'Kurren123/mssql.nvim',
  dependencies = { 'nvim-lualine/lualine.nvim' },
  opts = {
    keymap_prefix = '<leader>m',
  },
  config = function(_, opts)
    -- This sets up the plugin with your specified options, including the keymap prefix.
    require('mssql').setup(opts)

    -- Configure lualine to display the mssql component.
    require('lualine').setup {
      sections = {
        lualine_c = {
          require('mssql').lualine_component,
        },
      },
    }
  end,
}
