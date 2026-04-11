vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  'https://github.com/nvim-treesitter/nvim-treesitter',
})

-- Install parsers (nvim-treesitter on main branch is now just a parser manager;
-- highlight and indent are handled by Neovim 0.12 builtins)
vim.api.nvim_create_autocmd('User', {
  pattern = 'PackChanged',
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' then
      require('nvim-treesitter').install {
        'bash', 'c', 'diff', 'html', 'css', 'javascript', 'typescript',
        'lua', 'luadoc', 'markdown', 'markdown_inline', 'query',
        'vim', 'vimdoc', 'python', 'sql',
      }
    end
  end,
})

-- Ensure parsers are installed on first load
local desired_parsers = {
  'bash', 'c', 'diff', 'html', 'css', 'javascript', 'typescript',
  'lua', 'luadoc', 'markdown', 'markdown_inline', 'query',
  'vim', 'vimdoc', 'python', 'sql',
}

local installed = require('nvim-treesitter').get_installed()
local missing = vim.tbl_filter(function(lang)
  return not vim.list_contains(installed, lang)
end, desired_parsers)

if #missing > 0 then
  require('nvim-treesitter').install(missing)
end

-- Textobjects: swap
local swap = require('nvim-treesitter-textobjects.swap')
vim.keymap.set('n', '<leader>ap', function() swap.swap_next('@parameter.inner') end, { desc = 'Swap next parameter' })
vim.keymap.set('n', '<leader>aP', function() swap.swap_previous('@parameter.inner') end, { desc = 'Swap previous parameter' })

-- Textobjects: move
local move = require('nvim-treesitter-textobjects.move')

vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@function.outer') end, { desc = 'Next function start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']c', function() move.goto_next_start('@class.outer') end, { desc = 'Next class start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']i', function() move.goto_next_start('@conditional.outer') end, { desc = 'Next conditional start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']l', function() move.goto_next_start('@loop.outer') end, { desc = 'Next loop start' })

vim.keymap.set({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@function.outer') end, { desc = 'Next function end' })
vim.keymap.set({ 'n', 'x', 'o' }, ']C', function() move.goto_next_end('@class.outer') end, { desc = 'Next class end' })
vim.keymap.set({ 'n', 'x', 'o' }, ']I', function() move.goto_next_end('@conditional.outer') end, { desc = 'Next conditional end' })
vim.keymap.set({ 'n', 'x', 'o' }, ']L', function() move.goto_next_end('@loop.outer') end, { desc = 'Next loop end' })

vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@function.outer') end, { desc = 'Previous function start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[c', function() move.goto_previous_start('@class.outer') end, { desc = 'Previous class start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[i', function() move.goto_previous_start('@conditional.outer') end, { desc = 'Previous conditional start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[l', function() move.goto_previous_start('@loop.outer') end, { desc = 'Previous loop start' })

vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@function.outer') end, { desc = 'Previous function end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[C', function() move.goto_previous_end('@class.outer') end, { desc = 'Previous class end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[I', function() move.goto_previous_end('@conditional.outer') end, { desc = 'Previous conditional end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[L', function() move.goto_previous_end('@loop.outer') end, { desc = 'Previous loop end' })
