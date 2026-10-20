-- nvim-treesitter manages parsers and queries; Neovim provides highlighting.
local desired_parsers = require('plugins').parsers

-- Guarded: on a fresh machine the plugin may not be installed yet.
local has_treesitter, treesitter = pcall(require, 'nvim-treesitter')
if has_treesitter then
  local installed = treesitter.get_installed()
  local missing = vim.tbl_filter(function(lang)
    return not vim.list_contains(installed, lang)
  end, desired_parsers)

  if #missing > 0 then
    treesitter.install(missing)
  end
end

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
local has_textobjects, swap = pcall(require, 'nvim-treesitter-textobjects.swap')
if not has_textobjects then
  return
end
vim.keymap.set('n', '<leader>ap', function()
  swap.swap_next '@parameter.inner'
end, { desc = 'Swap next parameter' })
vim.keymap.set('n', '<leader>aP', function()
  swap.swap_previous '@parameter.inner'
end, { desc = 'Swap previous parameter' })

-- Textobjects: move to the next/previous semantic object. Keep these under
-- <leader>j so Vim's built-in bracket motions remain available.
local move = require 'nvim-treesitter-textobjects.move'

vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jf', function()
  move.goto_next_start '@function.outer'
end, { desc = 'Next function start' })
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jc', function()
  move.goto_next_start '@class.outer'
end, { desc = 'Next class start' })
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>ji', function()
  move.goto_next_start '@conditional.outer'
end, { desc = 'Next conditional start' })
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jl', function()
  move.goto_next_start '@loop.outer'
end, { desc = 'Next loop start' })

vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jF', function()
  move.goto_previous_start '@function.outer'
end, { desc = 'Previous function start' })
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jC', function()
  move.goto_previous_start '@class.outer'
end, { desc = 'Previous class start' })
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jI', function()
  move.goto_previous_start '@conditional.outer'
end, { desc = 'Previous conditional start' })
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jL', function()
  move.goto_previous_start '@loop.outer'
end, { desc = 'Previous loop start' })
