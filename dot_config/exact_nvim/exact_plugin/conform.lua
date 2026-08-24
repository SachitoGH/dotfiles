require('conform').setup {
  -- No format_on_save — manual only
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'isort', 'black' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescriptreact = { 'prettier' },
    html = { 'prettier' },
    css = { 'prettier' },
    c = { 'clang-format' },
    cpp = { 'clang-format' },
  },
}

vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = { start = { args.line1, 0 }, ['end'] = { args.line2, end_line:len() } }
  end
  require('conform').format { async = true, lsp_format = 'fallback', range = range }
end, { range = true, desc = 'Format buffer or selection' })

vim.keymap.set('n', '<leader>f', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = 'Format buffer' })

vim.keymap.set('x', '<leader>f', function()
  local first = vim.fn.line "'<"
  local last = vim.fn.line "'>"
  local end_line = vim.api.nvim_buf_get_lines(0, last - 1, last, true)[1]

  require('conform').format {
    async = true,
    lsp_format = 'fallback',
    range = { start = { first, 0 }, ['end'] = { last, #end_line } },
  }
end, { desc = 'Format selection' })
