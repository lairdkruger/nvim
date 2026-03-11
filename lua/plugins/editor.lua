return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	opts = {}, -- placeholder for future options
	config = function()
		require("config.editor").setup_multicursor()
	end,
}
