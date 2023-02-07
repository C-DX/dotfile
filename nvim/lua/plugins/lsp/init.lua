local servers = { "sumneko_lua", "clangd" }

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
    event = "BufReadPre",
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
        cond = function()
          return require("util").has("nvim-cmp")
        end,
      },
    },
    config = function()
      local keymaps = require("plugins.lsp.keymaps")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            on_attach = keymaps.on_attach,
            capabilities = capabilities,
          }
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ["rust_analyzer"] = function()
        --   require("rust-tools").setup {}
        -- end
      }
    end,
  },

  --formatter
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    config = function()
      local null_ls = require("null-ls")
      local formatting = null_ls.builtins.formatting

      null_ls.setup {
        sources = {
          formatting.stylua,
        },
      }
    end,
  },
}
