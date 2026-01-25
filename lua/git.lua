vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/sindrets/diffview.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/NeogitOrg/neogit" },
})

require("diffview").setup({})
require("neogit").setup({})

vim.keymap.set("n", "<leader>gg", function()
	require("neogit").open()
end, { desc = "Open Neogit" })
