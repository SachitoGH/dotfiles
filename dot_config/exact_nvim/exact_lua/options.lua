vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'

-- Hide command line, auto-show when recording macros
vim.o.cmdheight = 0
local macro_group = vim.api.nvim_create_augroup('MacroCmdHeight', { clear = true })
vim.api.nvim_create_autocmd('RecordingEnter', {
  group = macro_group,
  callback = function()
    vim.opt.cmdheight = 1
  end,
})
vim.api.nvim_create_autocmd('RecordingLeave', {
  group = macro_group,
  callback = function()
    vim.opt.cmdheight = 0
  end,
})

vim.o.showmode = false
vim.o.laststatus = 3

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 500

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0

vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.pumborder = 'single'

-- Experimental ui2 (0.12): removes "Press Enter" prompts, highlights cmdline
pcall(function()
  require('vim._core.ui2').enable {}
end)

-- WSL clipboard
if vim.fn.has 'wsl' == 1 then
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = true,
  }
end

vim.opt.fillchars = {
  diff = '╱',
}
