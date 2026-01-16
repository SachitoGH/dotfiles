return {
  "monaqa/dial.nvim",
  lazy = false,

  config = function()
    local augend = require("dial.augend")
    local map = require("dial.map")
    local config = require("dial.config")

    config.augends:register_group{
      default = {
        ------------------------------------------------------------------
        -- Signed decimal integers (including negative)
        ------------------------------------------------------------------
        augend.integer.alias.decimal_int,

        ------------------------------------------------------------------
        -- Other bases (still non-negative by default)
        ------------------------------------------------------------------
        augend.integer.alias.hex,
        augend.integer.alias.octal,
        augend.integer.alias.binary,

        ------------------------------------------------------------------
        -- Booleans
        ------------------------------------------------------------------
        augend.constant.alias.bool, -- true <-> false

        augend.constant.new{
          elements = { "True", "False" },
          word = true,
          cyclic = true,
        },

        ------------------------------------------------------------------
        -- Common toggles
        ------------------------------------------------------------------
        augend.constant.new{
          elements = { "yes", "no" },
          word = true,
          cyclic = true,
        },

        augend.constant.new{
          elements = { "on", "off" },
          word = true,
          cyclic = true,
        },

        ------------------------------------------------------------------
        -- Dates
        ------------------------------------------------------------------
        augend.date.alias["%Y-%m-%d"],
      },
    }

    vim.keymap.set("n", "<C-a>", map.inc_normal(), { desc = "Increment" })
    vim.keymap.set("n", "<C-x>", map.dec_normal(), { desc = "Decrement" })
    vim.keymap.set("v", "<C-a>", map.inc_visual(), { desc = "Increment" })
    vim.keymap.set("v", "<C-x>", map.dec_visual(), { desc = "Decrement" })
  end,
}
