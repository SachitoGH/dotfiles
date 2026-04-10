return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  lazy = false,
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  opts = {
    default_file_explorer = true,
    columns = { 'icon' },
    view_options = {
      show_hidden = true,
      natural_order = 'fast',
    },
    float = {
      border = 'rounded',
    },
  },
  config = function(_, opts)
    require('oil').setup(opts)

    local function toggle_oil(dir)
      local oil = require 'oil'
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == 'oil' then
          oil.close()
          return
        end
      end
      oil.open_float(dir)
    end

    vim.keymap.set('n', '<leader>go', function()
      toggle_oil '.'
    end, { desc = 'Oil: Toggle float in CWD' })

    vim.keymap.set('n', '<leader>o', function()
      toggle_oil(vim.fn.expand '%:p:h')
    end, { desc = "Oil: Toggle float in current file's directory" })
  end,
}
