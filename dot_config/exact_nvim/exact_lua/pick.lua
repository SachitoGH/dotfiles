-- fzf-lua is loaded and configured on the first picker call instead of at startup.
local configured = false

local function fzf()
  local fzf_lua = require 'fzf-lua'
  if not configured then
    configured = true
    fzf_lua.setup {
      'default-title',
      fzf_opts = { ['--layout'] = 'reverse' },
      winopts = {
        border = 'rounded',
        preview = { layout = 'vertical', vertical = 'down:50%' },
      },
    }
  end
  return fzf_lua
end

-- pick('files') returns a function that opens that picker, for use in keymaps.
return function(name, opts)
  return function()
    fzf()[name](opts)
  end
end
