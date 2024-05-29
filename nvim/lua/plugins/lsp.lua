return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
    config = function()
      require("lspsaga").setup({
        lightbulb = {
          sign = false,
        },
      })
    end,
  },
  -- replace LSP keymaps
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      keys[#keys + 1] = {
        "[w",
        function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARN })
        end,
      }
      keys[#keys + 1] = {
        "]w",
        function()
          require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARN })
        end,
      }
      keys[#keys + 1] = {
        "[e",
        function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
      }
      keys[#keys + 1] = {
        "]e",
        function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
      }

      keys[#keys + 1] = { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>" }
      keys[#keys + 1] = { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>" }
      keys[#keys + 1] = { "gd", "<cmd>Lspsaga goto_definition<cr>" }
      keys[#keys + 1] = { "gr", "<cmd>Lspsaga finder ref<cr>" }
      keys[#keys + 1] = { "gI", "<cmd>Lspsaga finder imp<cr>" }
      keys[#keys + 1] = { "gy", "<cmd>Lspsaga goto_type_definition<cr>" }
      keys[#keys + 1] = { "K", "<cmd>Lspsaga hover_doc<cr>" }
      keys[#keys + 1] = { "gh", "<cmd>Lspsaga finder<cr>" }
      keys[#keys + 1] = { "<leader>ca", "<cmd>Lspsaga code_action<cr>" }
      keys[#keys + 1] = { "<leader>cr", "<cmd>Lspsaga rename<cr>" }
      keys[#keys + 1] = { "<leader>co", "<cmd>Lspsaga outline<cr>" }
      keys[#keys + 1] = { "<leader>ch", "<cmd>Lspsaga incoming_calls<cr>" }
      keys[#keys + 1] = { "<leader>cH", "<cmd>Lspsaga outgoing_calls<cr>" }
    end,
  },
}
