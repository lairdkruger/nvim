return {
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    config = function()
      require("diffview").setup({})
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = "Neogit",
    config = function()
      require("neogit").setup({})
    end,
    keys = {
      {
        "<leader>g",
        function()
          require("neogit").open()
        end,
        desc = "Open Neogit",
      },
    },
  },
}
