vim.pack.add({ 'https://github.com/monaqa/dial.nvim' })

local augend = require('dial.augend')
local map = require('dial.map')
local config = require('dial.config')

config.augends:register_group {
  default = {
    augend.integer.alias.decimal_int,
    augend.integer.alias.hex,
    augend.integer.alias.octal,
    augend.integer.alias.binary,
    augend.constant.alias.bool,
    augend.constant.new { elements = { 'True', 'False' }, word = true, cyclic = true },
    augend.constant.new { elements = { 'yes', 'no' }, word = true, cyclic = true },
    augend.constant.new { elements = { 'on', 'off' }, word = true, cyclic = true },
    augend.date.alias['%Y-%m-%d'],
  },
}

vim.keymap.set('n', '<C-a>', map.inc_normal(), { desc = 'Increment' })
vim.keymap.set('n', '<C-x>', map.dec_normal(), { desc = 'Decrement' })
vim.keymap.set('v', '<C-a>', map.inc_visual(), { desc = 'Increment' })
vim.keymap.set('v', '<C-x>', map.dec_visual(), { desc = 'Decrement' })
