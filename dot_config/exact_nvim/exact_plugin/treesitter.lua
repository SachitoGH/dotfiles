-- nvim-treesitter manages parsers and queries; Neovim provides highlighting.
local desired_parsers = require('plugins').parsers

-- Install missing parsers after the first draw (only matters on a new machine).
-- Guarded: on a fresh machine the plugin may not be installed yet.
require 'later'(function()
  local has_treesitter, treesitter = pcall(require, 'nvim-treesitter')
  if not has_treesitter then
    return
  end

  local installed = treesitter.get_installed()
  local missing = vim.tbl_filter(function(lang)
    return not vim.list_contains(installed, lang)
  end, desired_parsers)

  if #missing > 0 then
    treesitter.install(missing)
  end
end)

-- nvim-treesitter supplies parsers and queries; highlighting is enabled by
-- Neovim itself for every configured language.
vim.api.nvim_create_autocmd('FileType', {
  callback = function(event)
    local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
    if lang and vim.list_contains(desired_parsers, lang) then
      pcall(vim.treesitter.start, event.buf, lang)
    end
  end,
})

-- Textobjects: swap
-- Modules are required on keypress, so they cost nothing at startup.
local function swap(method, query)
  return function()
    require('nvim-treesitter-textobjects.swap')[method](query)
  end
end
vim.keymap.set('n', '<leader>ap', swap('swap_next', '@parameter.inner'), { desc = 'Swap next parameter' })
vim.keymap.set('n', '<leader>aP', swap('swap_previous', '@parameter.inner'), { desc = 'Swap previous parameter' })

-- Textobjects: move to the next/previous semantic object. Keep these under
-- <leader>j so Vim's built-in bracket motions remain available.
local function move(method, query)
  return function()
    require('nvim-treesitter-textobjects.move')[method](query)
  end
end

vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jf', move('goto_next_start', '@function.outer'), { desc = 'Next function start' })
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jc', move('goto_next_start', '@class.outer'), { desc = 'Next class start' })
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>ji', move('goto_next_start', '@conditional.outer'), { desc = 'Next conditional start' })
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jl', move('goto_next_start', '@loop.outer'), { desc = 'Next loop start' })

vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jF', move('goto_previous_start', '@function.outer'), { desc = 'Previous function start' })
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jC', move('goto_previous_start', '@class.outer'), { desc = 'Previous class start' })
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jI', move('goto_previous_start', '@conditional.outer'), { desc = 'Previous conditional start' })
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jL', move('goto_previous_start', '@loop.outer'), { desc = 'Previous loop start' })
