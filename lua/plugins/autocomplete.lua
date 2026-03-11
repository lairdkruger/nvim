require("blink.cmp").setup({
	sources = {
		default = { "lsp", "path", "buffer" },
	},
})

vim.g.copilot_filetypes = {
	["*"] = true,
}
