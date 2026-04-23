-- Treesitter highlighting for all filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

-- Redraw statusline on LSP progress updates
vim.api.nvim_create_autocmd("LspProgress", {
	group = vim.api.nvim_create_augroup("lsp-progress-redraw", { clear = true }),
	callback = function()
		vim.cmd.redrawstatus()
	end,
})

-- Auto-read files changed on disk
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("auto-read", { clear = true }),
	command = "checktime",
})

-- Prevent nvim-tree from interfering with codediff tabs
vim.api.nvim_create_autocmd("User", {
	pattern = "CodeDiffOpen",
	callback = function()
		vim.api.nvim_clear_autocmds({ group = "NvimTree" })
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "CodeDiffClose",
	callback = function()
		require("nvim-tree.autocmd").global()
	end,
})
