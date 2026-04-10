return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('render-markdown').setup {
      -- Enable rendering by default
      enabled = true,
      -- Configure which modes to render in
      render_modes = { 'n' },
    }
  end,
}
