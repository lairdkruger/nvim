-- Auto format on save using Neovim's built-in LSP client
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		vim.lsp.buf.format({ bufnr = args.buf, async = false })
	end,
})
