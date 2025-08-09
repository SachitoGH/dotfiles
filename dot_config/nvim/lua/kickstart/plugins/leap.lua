return {
  'ggandor/leap.nvim',
  config = function()
    -- This function runs after the plugin has been loaded
    require('leap').set_default_mappings()
    vim.keymap.set({ 'n', 'x', 'o' }, 'gs', function()
      require('leap.remote').action()
    end)
  end,
}
