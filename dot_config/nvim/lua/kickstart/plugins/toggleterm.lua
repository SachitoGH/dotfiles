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

    -- Keymap: Run current Python file in floating terminal
    vim.keymap.set('n', '<leader>p', function()
      if vim.bo.filetype == 'python' then
        vim.cmd 'w' -- Save the current file

        -- Get the full path and directory of the current file, shell-escaped
        local file_path = vim.fn.shellescape(vim.fn.expand '%:p')
        local file_dir = vim.fn.shellescape(vim.fn.expand '%:h')
        local file_name = vim.fn.shellescape(vim.fn.expand '%:t')

        -- Construct the command to run: change directory, then execute python3 with -i
        local run_command = 'cd ' .. file_dir .. ' && python3 -i ' .. file_name

        require('toggleterm.terminal').Terminal
          :new({
            cmd = run_command,
            direction = 'float',
            float_opts = {
              border = 'rounded',
              width = math.floor(vim.o.columns * 0.8),
              height = math.floor(vim.o.lines * 0.6),
              row = math.floor((vim.o.lines - math.floor(vim.o.lines * 0.6)) / 2),
              col = math.floor((vim.o.columns - math.floor(vim.o.columns * 0.8)) / 2),
            },
          })
          :toggle()
      else
        vim.notify('Not a Python file (filetype is ' .. vim.bo.filetype .. ').', vim.log.levels.WARN, { title = 'Run Script' })
      end
    end, { desc = 'Run [P]ython File (Floating)' })
  end,
}
