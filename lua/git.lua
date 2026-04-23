-- Git diff viewer
require("codediff").setup({
	diff = { layout = "side-by-side" },
})
vim.keymap.set("n", "<leader>d", "<cmd>CodeDiff<cr>", { desc = "Git diff" })
