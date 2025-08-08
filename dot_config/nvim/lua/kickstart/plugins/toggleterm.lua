-- ~/.config/nvim/lua/plugins/toggleterm.lua
return {
  'akinsho/toggleterm.nvim',
  version = '*', -- Use latest release
  cmd = 'ToggleTerm', -- This makes it lazy-loadable
  opts = {
    size = 20,
    open_mapping = '<leader>tt',
    direction = 'float',
    shade_filetypes = {},
    shading_factor = 1,
    start_in_insert = true,
    insert_mappings = false,
    persist_size = true,
    close_on_exit = true, -- Important for process termination

    terminals = {
      {
        name = 'python_runner',
        cmd = { 'python3' },
        hidden = true,
        direction = 'float',
      },
    },
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    -- Keymap: Close the ToggleTerm window with 'Ctrl-c' directly in terminal-insert mode
    vim.keymap.set('t', '<C-c>', '<C-\\><C-n>:ToggleTerm<CR>', { noremap = true, silent = true, desc = 'Close terminal' })
  end,
}
