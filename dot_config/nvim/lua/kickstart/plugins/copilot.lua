return {
  "github/copilot.vim",
  init = function()
    vim.g.copilot_no_tab_map = true
    -- START DISABLED: Copilot will be off every time you open Neovim
    vim.g.copilot_enabled = false
  end,
  config = function()
    -- Accept suggestion with Ctrl + L
    vim.keymap.set('i', '<C-l>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false
    })

    -- Toggle Copilot with <leader>ai
    vim.keymap.set('n', '<leader>ai', function()
      vim.g.copilot_enabled = not vim.g.copilot_enabled
      if vim.g.copilot_enabled then
        print("Copilot Enabled")
      else
        print("Copilot Disabled")
      end
    end, { desc = "Toggle Copilot" })
  end
}
