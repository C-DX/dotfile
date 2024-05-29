-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- VS Code-like terminal keymap
map("n", "<C-`>", function()
  LazyVim.terminal(nil, { cwd = LazyVim.root() })
end)
map("t", "<C-`>", "<cmd>close<cr>")
