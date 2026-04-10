return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Provides server config files in lsp/ (cmd, root_dir, filetypes).
    -- Do NOT call require('lspconfig') — that framework is deprecated in favour of vim.lsp.config.
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      -- LSP keymaps (override 0.11+ builtins to use Telescope instead of quickfix)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('grn', vim.lsp.buf.rename, 'Rename')
          map('gra', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
          map('grr', require('telescope.builtin').lsp_references, 'Goto References')
          map('gri', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
          map('grd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
          map('grD', vim.lsp.buf.declaration, 'Goto Declaration')
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
          map('grt', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
          map('<Leader>d', vim.diagnostic.open_float, 'Show diagnostics')
          map('<Leader>tv', function()
            vim.diagnostic.config { virtual_text = not vim.diagnostic.config().virtual_text }
          end, '[T]oggle [V]irtual text')

          -- Document highlight on cursor hold
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight') then
            local group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, { buffer = event.buf, group = group, callback = vim.lsp.buf.document_highlight })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, { buffer = event.buf, group = group, callback = vim.lsp.buf.clear_references })
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

      -- Per-server overrides on top of nvim-lspconfig defaults
      vim.lsp.config('emmet_ls', {
        filetypes = { 'html', 'css', 'scss', 'javascriptreact', 'typescriptreact' },
      })
      vim.lsp.config('lua_ls', {
        settings = { Lua = { completion = { callSnippet = 'Replace' } } },
      })

      local servers = { 'clangd', 'pyright', 'html', 'cssls', 'angularls', 'emmet_ls', 'lua_ls', 'ts_ls' }

      require('mason-lspconfig').setup {
        ensure_installed = servers,
        automatic_enable = false, -- we enable explicitly below
      }

      vim.lsp.enable(servers)
    end,
  },
}
