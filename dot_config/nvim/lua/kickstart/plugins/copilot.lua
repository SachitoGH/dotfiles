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
  end
}
