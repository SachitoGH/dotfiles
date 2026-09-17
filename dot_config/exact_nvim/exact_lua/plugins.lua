local M = {}

M.parsers = {
  'bash',
  'c',
  'cpp',
  'css',
  'diff',
  'html',
  'javascript',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
}

-- Parsers and queries must be updated together with nvim-treesitter.
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(event)
    local spec = event.data.spec
    if spec.name ~= 'nvim-treesitter' or not vim.tbl_contains({ 'install', 'update' }, event.data.kind) then
      return
    end

    vim.schedule(function()
      local ok, treesitter = pcall(require, 'nvim-treesitter')
      if ok then
        treesitter.update(M.parsers)
      end
    end)
  end,
})

vim.pack.add {
  'https://github.com/EdenEast/nightfox.nvim',
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.x' },
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/echasnovski/mini.nvim',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  'https://github.com/windwp/nvim-ts-autotag',
  'https://github.com/christoomey/vim-tmux-navigator',
}

return M
