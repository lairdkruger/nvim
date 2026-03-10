require("diffview").setup({})
require("neogit").setup({})

vim.keymap.set("n", "<leader>g", function()
	require("neogit").open()
end, { desc = "Open Neogit" })
