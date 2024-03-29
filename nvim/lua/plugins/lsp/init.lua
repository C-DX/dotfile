local servers = { "lua_ls", "clangd", "rust_analyzer" }

return {
  -- lsp manager
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = servers,
        },
      },
      {
        "hrsh7th/cmp-nvim-lsp",
      },
      "simrat39/rust-tools.nvim",
    },
    keys = {
      { "<leader>cF", require("plugins.lsp.keymaps").toggle, desc = "Toggle format on Save" },
    },
    opts = {
      autoformat = true, -- automatically format on save
    },
    config = function(_, opts)
      local keymaps = require("plugins.lsp.keymaps")
      keymaps.autoformat = opts.autoformat -- setup autoformat
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            on_attach = keymaps.on_attach,
            capabilities = capabilities,
          })
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        ["rust_analyzer"] = function()
          require("rust-tools").setup({
            server = {
              on_attach = keymaps.on_attach,
              capabilities = capabilities,
              settings = {
                ["rust-analyzer"] = {
                  checkOnSave = {
                    command = "clippy",
                  },
                },
              },
            },
          })
        end,
      })
    end,
  },

  --formatter
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      local formatting = null_ls.builtins.formatting
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
        sources = {
          formatting.stylua,
          formatting.shfmt,
          formatting.fish_indent,
        },
      }
    end,
  },
}
