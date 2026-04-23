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

-- Native autocomplete (0.12)
vim.o.autocomplete = true
vim.o.completeopt = "menu,menuone,noselect,nearest"
vim.o.pumborder = "rounded"
vim.o.pummaxwidth = 40

-- Statusline with LSP progress and diagnostic status
vim.o.statusline = "%<%f %h%m%r %{v:lua.vim.lsp.status()}%=%{v:lua.vim.diagnostic.status()}  %-14.(%l,%c%V%) %P"
