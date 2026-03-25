return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{ "<leader>h", "<cmd>Telescope help_tags<cr>", desc = "Find help" },
			{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{
				"<leader>/",
				function()
					require("telescope.builtin").live_grep({
						additional_args = function()
							return { "--fixed-strings" }
						end,
					})
				end,
				desc = "Find content",
			},
			{ "<leader>s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find document symbols" },
			{ "<leader>S", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Find workspace symbols" },
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<CR>"] = require("telescope.actions").select_default,
						},
						n = {
							["<CR>"] = require("telescope.actions").select_default,
						},
					},
					file_ignore_patterns = {
						"node_modules/",
						".git/",
						"dist/",
						"build/",
						".next/",
						".svelte-kit/",
						".cache/",
						"coverage/",
						"target/",
						"vendor/",
						"nvim%-pack%-lock.json",
						"package%-lock.json",
						"yarn%.lock",
						"pnpm%-lock.yaml",
						".DS_Store",
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})
		end,
	},
	{
		"nvim-lua/plenary.nvim",
	},
}
