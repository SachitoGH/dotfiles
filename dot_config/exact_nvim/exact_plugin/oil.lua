require('oil').setup {
  default_file_explorer = true,
  columns = { 'icon' },
  view_options = {
    show_hidden = true,
    natural_order = 'fast',
  },
  float = {
    border = 'rounded',
  },
}

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

vim.keymap.set('n', '<leader>o', function()
  toggle_oil(vim.fn.expand '%:p:h')
end, { desc = 'Toggle file explorer' })
