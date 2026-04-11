vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
})

require('mason').setup {}

-- LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local map = function(keys, func, desc, mode)
      vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- 0.12 defaults: gra (code_action), grn (rename), grx (codelens),
    -- grr (references), gri (implementation), grt (type_def), gO (symbols),
    -- K (hover), <C-S> (signature_help).
    -- Override some to use fzf-lua instead of quickfix:
    local fzf = require 'fzf-lua'
    map('grr', fzf.lsp_references, 'Goto References')
    map('gri', fzf.lsp_implementations, 'Goto Implementation')
    map('grd', fzf.lsp_definitions, 'Goto Definition')
    map('grD', vim.lsp.buf.declaration, 'Goto Declaration')
    map('gO', fzf.lsp_document_symbols, 'Document Symbols')
    map('gW', fzf.lsp_live_workspace_symbols, 'Workspace Symbols')
    map('grt', fzf.lsp_typedefs, 'Type Definition')
    map('<Leader>d', vim.diagnostic.open_float, 'Show diagnostics')
    map('<Leader>tv', function()
      vim.diagnostic.config { virtual_text = not vim.diagnostic.config().virtual_text }
    end, '[T]oggle [V]irtual text')

    -- Document highlight on cursor hold
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight') then
      local group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf, group = group, callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf, group = group, callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

-- Diagnostics
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = { text = { [1] = '󰅚 ', [2] = '󰀪 ', [3] = '󰋽 ', [4] = '󰌶 ' } },
  virtual_text = { source = 'if_many', spacing = 2 },
}

-- Apply blink.cmp capabilities to all servers
vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

-- Server-specific overrides live in lsp/*.lua files (0.12 convention).
-- nvim-lspconfig provides base configs; our lsp/ dir merges on top.

local servers = { 'clangd', 'pyright', 'html', 'cssls', 'angularls', 'emmet_ls', 'lua_ls', 'ts_ls' }

-- On Termux (Android), clangd and lua_ls are installed system-wide via pkg
local mason_servers = servers
if vim.fn.has 'android' == 1 then
  mason_servers = vim.tbl_filter(function(s)
    return s ~= 'clangd' and s ~= 'lua_ls'
  end, servers)
end

require('mason-lspconfig').setup {
  ensure_installed = mason_servers,
  automatic_enable = false,
}

vim.lsp.enable(servers)

-- Convenience commands removed in 0.12
vim.api.nvim_create_user_command('LspInfo', 'checkhealth vim.lsp', { desc = 'LSP info' })
vim.api.nvim_create_user_command('LspLog', function()
  vim.cmd.edit(vim.fs.joinpath(vim.fn.stdpath('state'), 'lsp.log'))
end, { desc = 'LSP log' })
vim.api.nvim_create_user_command('LspRestart', 'lsp restart', { desc = 'LSP restart' })
