vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.encoding = "utf-8"
-- opt.formatoptions = "jcroqlnt" -- default: tcqj
opt.list = true -- Show some invisible characters
opt.listchars:append("space:⋅")
opt.mouse = "a" -- Enable mouse mode
opt.number = true
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true
opt.showmode = false -- Don't show mode since we have a statusline
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.termguicolors = true -- True color support
opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode

-- Autocomplete
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append({ c = true }) -- Avoid showing extra messages when using completion

-- Indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftround = true -- Round indent
opt.shiftwidth = 4 -- Size of an indent
opt.smartindent = true -- Insert indents automatically
opt.tabstop = 4 -- Number of spaces tabs count for

-- Permanent undo
-- opt.undofile = true
-- opt.undodir = os.getenv("HOME") .. "/.nvim_undo"

-- Search
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"
opt.ignorecase = true
-- opt.inccommand = "split" -- Preview incremental substitute
opt.smartcase = true -- Don't ignore case with capitals
