-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.g.snacks_animate = false

if vim.fn.has("win32") then
  vim.o.shell = "pwsh"
end

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h13"
  vim.g.neovide_refresh_rate = 165
end
