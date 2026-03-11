vim.g.mapleader = " "

vim.g.have_nerd_font = true

vim.o.updatetime = 500

vim.o.clipboard = "unnamedplus"

vim.opt.termguicolors = true
vim.opt.winborder = "rounded"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.fillchars = { eob = " " }

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.o.splitright = true
vim.o.splitbelow = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.shiftround = true

vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.autoread = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Medium Jumps
-- move by word
map({ "n", "v" }, "<C-h>", "b", opts)
map({ "n", "v" }, "<C-l>", "w", opts)
-- move by block
map({ "n", "v" }, "<C-j>", "}", opts)
map({ "n", "v" }, "<C-k>", "{", opts)

-- Large Jumps
-- move to start/end of line
map({ "n", "v" }, "H", "^", opts)
map({ "n", "v" }, "L", "$", opts)
-- move to top/bottom of file
map({ "n", "v" }, "J", "G", opts)
map({ "n", "v" }, "K", "gg", opts)

-- Move lines
map("n", "<M-j>", ":m+<CR>", opts)
map("n", "<M-k>", ":m-2<CR>", opts)
map("v", "<M-j>", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "<M-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- Select all
map({ "n", "v" }, "<D-a>", "ggVG", opts)
