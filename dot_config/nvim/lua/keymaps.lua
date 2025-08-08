-- ~/.config/nvim/lua/keymaps.lua

-- [[ Basic Keymaps ]]

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Oil.nvim Floating Window Keymaps (Moved here to ensure it's defined at startup)
vim.keymap.set('n', '<leader>o', function()
  require('oil').open_float '.'
end, { desc = 'Oil: Open float in CWD' })

-- Oil: Open float in current file's directory (commented out)
-- vim.keymap.set('n', '<leader>oF', function()
--   require('oil').open_float(vim.fn.expand '%:p:h')
-- end, { desc = "Oil: Open float in current file's directory" })

-- Recommended Python Run Keymap (Floating Term via ToggleTerm)
-- This keymap uses `toggleterm.nvim` to run the current Python file in a floating terminal window.
-- It saves the current file, constructs the command to run it from its directory,
-- and then creates/toggles a floating terminal to execute this command.
vim.keymap.set('n', '<leader>r', function()
  -- Check if the current file is a Python file
  if vim.bo.filetype == 'python' then
    vim.cmd 'w' -- Save the current file

    -- Get the full path and directory of the current file, shell-escaped
    local file_path = vim.fn.shellescape(vim.fn.expand '%:p')
    local file_dir = vim.fn.shellescape(vim.fn.expand '%:h')
    local file_name = vim.fn.shellescape(vim.fn.expand '%:t')

    -- Construct the command to run: change directory, then execute python3 with -i
    -- The '-i' flag keeps the Python interpreter interactive after the script finishes.
    local run_command = 'cd ' .. file_dir .. ' && python3 -i ' .. file_name

    -- Use ToggleTerm to open/toggle a floating terminal and execute the command.
    -- This `require` call will trigger `toggleterm.nvim` to load if it's lazy-loaded.
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

-- vim: ts=2 sts=2 sw=2 et
