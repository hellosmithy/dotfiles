return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- merge into existing treesitter config
      vim.list_extend(opts.ensure_installed, {
        -- add elixir syntax highlighting
        "elixir",
        "heex",
        "eex",
      })
    end,
  },
}
