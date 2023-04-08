return {
  --auto pairs
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = true,
  },

  -- surround
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },

  -- comments
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    config = function()
      require("mini.comment").setup()
    end,
  },
}
