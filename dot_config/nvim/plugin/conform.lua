vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

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
    scss = { 'prettier' },
    json = { 'prettier' },
    yaml = { 'prettier' },
    markdown = { 'prettier' },
    c = { 'clang-format' },
    sql = { 'sql_formatter' },
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

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = 'Format buffer' })
