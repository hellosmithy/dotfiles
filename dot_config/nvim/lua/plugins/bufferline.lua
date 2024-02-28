return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = "VeryLazy",
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "[b",    "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "]b",    "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
  },
  opts = {
    -- stylua: ignore
    close_command = function(n) require("mini.bufremove").delete(n, false) end,
    -- stylua: ignore
    right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
    always_show_bufferline = false,
  },
  config = function()
    require("bufferline").setup(opts)
  end,
}
