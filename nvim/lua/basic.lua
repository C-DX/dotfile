vim.o.encoding = "utf-8"

vim.o.nocompatible = true

vim.o.number = true
vim.o.relativenumber = true
-- highlight current line
vim.o.cursorline = true
-- 特殊显示空格等字符
-- vim.o.list = true
-- auto indent
vim.o.filetype = "plugin"

-- undo persistence
vim.o.undodir = vim.fn.expand('~/.nvim/undodir')
vim.o.undofile = true
