-- lua/plugins/colors.lua
return {
  {
    "uga-rosa/ccc.nvim",
    event = "VeryLazy",
    opts = { highlighter = { auto_enable = true, lsp = true } },
    keys = {
      { "<leader>cp", "<cmd>CccPick<cr>", desc = "Color Picker" },
      { "<leader>cc", "<cmd>CccConvert<cr>", desc = "Color Convert" },
    },
  },
}
