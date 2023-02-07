local M = {}

function M.on_attach(client, bufnr)
  local function map(mode, l, r, desc)
    vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
  map("n", "<leader>cl", "<cmd>LspInfo<cr>", "Lsp Info")
  map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", "Goto Definition")
  map("n", "gr", "<cmd>Telescope lsp_references<cr>", "References")
  map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
  map("n", "gI", "<cmd>Telescope lsp_implementations<cr>", "Goto Implementation")
  map("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", "Goto Type Definition")
  map("n", "K", vim.lsp.buf.hover, "Hover")
  map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
  map("i", "<c-k>", vim.lsp.buf.signature_help, "Signature Help")
  map("n", "]d", M.diagnostic_goto(true), "Next Diagnostic")
  map("n", "[d", M.diagnostic_goto(false), "Prev Diagnostic")
  map("n", "]e", M.diagnostic_goto(true, "ERROR"), "Next Error")
  map("n", "[e", M.diagnostic_goto(false, "ERROR"), "Prev Error")
  map("n", "]w", M.diagnostic_goto(true, "WARN"), "Next Warning")
  map("n", "[w", M.diagnostic_goto(false, "WARN"), "Prev Warning")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("n", "<leader>cf", M.format, "Format Document")
  map("v", "<leader>cf", M.format, "Format Range")
  map("n", "<leader>cr", M.rename, "Rename")
end

function M.format()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

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

function M.rename()
  if pcall(require, "inc_rename") then
    return ":IncRename " .. vim.fn.expand("<cword>")
  else
    vim.lsp.buf.rename()
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

return M
