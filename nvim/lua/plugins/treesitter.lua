return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<C-space>", desc = "Incremental selection" },
      { "<bs>", desc = "Shrink selection", mode = "x" },
    },
    opts = {
      -- A list of parser names
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "go",
        "python",
        "regex",
        "rust",
        "vim",
        "yaml",
      },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      highlight = { enable = true },
      -- Indentation based on treesitter
      indent = { enable = true, disable = {} },
      -- Incremental selection based on the named nodes from the grammar
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>", -- set to `false` to disable one of the mappings
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
