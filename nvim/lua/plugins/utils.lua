return {
  {
    "folke/persistence.nvim",
    keys = {
      {
        "<leader>qS",
        function()
          require("persistence").select()
        end,
        desc = "Select Session",
      },
    },
  },
}
