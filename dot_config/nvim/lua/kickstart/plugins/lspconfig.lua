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
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      -- Helper: Map LSP keys
      local on_attach = function(event)
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

        -- Diagnostics
        map('<Leader>d', vim.diagnostic.open_float, 'Show diagnostics')
        map('<Leader>gd', function()
          vim.diagnostic.config { virtual_text = not vim.diagnostic.config().virtual_text }
        end, 'Toggle virtual text')

        -- Document Highlight Logic
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/documentHighlight') then
          local group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, { buffer = event.buf, group = group, callback = vim.lsp.buf.document_highlight })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, { buffer = event.buf, group = group, callback = vim.lsp.buf.clear_references })
        end
      end

      vim.api.nvim_create_autocmd('LspAttach', { callback = on_attach })

      -- Diagnostic Styling
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = { text = { [1] = '󰅚 ', [2] = '󰀪 ', [3] = '󰋽 ', [4] = '󰌶 ' } },
        virtual_text = { source = 'if_many', spacing = 2 },
      })

      -- Server Configurations
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local servers = {
        clangd = {},
        pyright = {},
        html = {},
        cssls = {},
        angularls = {},
        emmet_ls = {
          filetypes = { 'html', 'css', 'scss', 'javascriptreact', 'typescriptreact' }
        },
        lua_ls = {
          settings = { Lua = { completion = { callSnippet = 'Replace' } } }
        },
      }

      require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
