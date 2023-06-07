local M = {}

M.autoformat = true

function M.on_attach(client, bufnr)
  -- don't format if client disabled it
  if
    client.config
    and client.config.capabilities
    and client.config.capabilities.documentFormattingProvider == false
  then
    return
  end

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormatting" .. bufnr, {}),
      buffer = bufnr,
      callback = function()
        if M.autoformat then
          M.format()
        end
      end,
    })
  end

  local function map(mode, l, r, desc)
    vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>cl", "<cmd>LspInfo<cr>", "Lsp Info")
  map("n", "<leader>cf", M.format, "Format Document")
  map("v", "<leader>cf", M.format, "Format Range")

  -- Telescope
  map("n", "gr", "<cmd>Telescope lsp_references<cr>", "References")

  -- Lspsaga
  -- map("n", "gh", "<cmd>Lspsaga lsp_finder<cr>", "Find the symbol's definition")
  -- map("n", "K", "<cmd>Lspsaga hover_doc<cr>", "Hover")
  -- map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<cr>", "Code action")
  -- map("n", "<leader>cr", "<cmd>Lspsaga rename<cr>", "Rename for entire file")
  -- map("n", "<leader>cR", "<cmd>Lspsaga rename ++project<cr>", "Rename for selected files")
  -- map("n", "gp", "<cmd>Lspsaga peek_definition<cr>", "Peek definition")
  -- map("n", "gd", "<cmd>Lspsaga goto_definition<cr>", "Goto definition")
  -- map("n", "gt", "<cmd>Lspsaga peek_type_definition<cr>", "Peek type definition")
  -- map("n", "gT", "<cmd>Lspsaga goto_type_definition<cr>", "Goto type definition")
  -- map("n", "<leader>co", "<cmd>Lspsaga outline<cr>", "Code Outline")
  -- -- diagnostics
  -- map("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics")
  -- map("n", "<leader>db", "<cmd>Lspsaga show_buf_diagnostics<cr>", "Buffer Diagnostics")
  -- map("n", "<leader>dw", "<cmd>Lspsaga show_workspace_diagnostics<cr>", "Workspace Diagnostics")
  -- map("n", "<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", "Cursor Diagnostics")
  -- -- diagnostic jump
  -- map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Prev Diagnostic")
  -- map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next Diagnostic")
  -- -- diagnostic jump with filters such as only jumping to an error
  -- map("n", "[E", function()
  --   require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
  -- end, "Prev Error")
  -- map("n", "]E", function()
  --   require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
  -- end, "Next Error")
end

function M.toggle()
  local Util = require("lazy.core.util")

  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    M.autoformat = true
  else
    M.autoformat = not M.autoformat
  end
  if M.autoformat then
    Util.info("Enabled format on save", { title = "Format" })
  else
    Util.warn("Disabled format on save", { title = "Format" })
  end
end

---@param opts? {force?:boolean}
function M.format(opts)
  local buf = vim.api.nvim_get_current_buf()
  if vim.b.autoformat == false and not (opts and opts.force) then
    return
  end
  local ft = vim.bo[buf].filetype
  local have_nls = package.loaded["null-ls"]
    and (#require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0)

  vim.lsp.buf.format(vim.tbl_deep_extend("force", {
    bufnr = buf,
    filter = function(client)
      if have_nls then
        return client.name == "null-ls"
      end
      return client.name ~= "null-ls"
    end,
  }, require("util").opts("nvim-lspconfig").format or {}))
end

return M
