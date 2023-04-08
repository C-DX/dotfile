local M = {}

function M.on_attach(client, bufnr)
  local function map(mode, l, r, desc)
    vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>cl", "<cmd>LspInfo<cr>", "Lsp Info")
  map("n", "<leader>cf", M.format, "Format Document")
  map("v", "<leader>cf", M.format, "Format Range")

  -- Telescope
  map("n", "gr", "<cmd>Telescope lsp_references<cr>", "References")

  -- Lspsaga
  map("n", "gh", "<cmd>Lspsaga lsp_finder<cr>", "Find the symbol's definition")
  map("n", "K", "<cmd>Lspsaga hover_doc<cr>", "Hover")
  map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<cr>", "Code action")
  map("n", "<leader>cr", "<cmd>Lspsaga rename<cr>", "Rename for entire file")
  map("n", "<leader>cR", "<cmd>Lspsaga rename ++project<cr>", "Rename for selected files")
  map("n", "gp", "<cmd>Lspsaga peek_definition<cr>", "Peek definition")
  map("n", "gd", "<cmd>Lspsaga goto_definition<cr>", "Goto definition")
  map("n", "gt", "<cmd>Lspsaga peek_type_definition<cr>", "Peek type definition")
  map("n", "gT", "<cmd>Lspsaga goto_type_definition<cr>", "Goto type definition")
  map("n", "<leader>co", "<cmd>Lspsaga outline<cr>", "Code Outline")
  -- diagnostics
  map("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics")
  map("n", "<leader>db", "<cmd>Lspsaga show_buf_diagnostics<cr>", "Buffer Diagnostics")
  map("n", "<leader>dw", "<cmd>Lspsaga show_workspace_diagnostics<cr>", "Workspace Diagnostics")
  map("n", "<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", "Cursor Diagnostics")
  -- diagnostic jump
  map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Prev Diagnostic")
  map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next Diagnostic")
  -- diagnostic jump with filters such as only jumping to an error
  map("n", "[E", function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, "Prev Error")
  map("n", "]E", function()
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, "Next Error")
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
