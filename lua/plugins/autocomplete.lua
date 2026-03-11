return {
	{
		"saghen/blink.cmp",
		config = function(_, opts)
			require("blink.cmp").setup({
				sources = {
					default = { "lsp", "path", "buffer" },
				},
			})
		end,
	}
}