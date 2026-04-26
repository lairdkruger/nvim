local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		mappings = {
			i = { ["<CR>"] = actions.select_default },
			n = { ["<CR>"] = actions.select_default },
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
		find_files = { hidden = true },
	},
})

local map = vim.keymap.set
map("n", "<leader>h", builtin.help_tags, { desc = "Find help" })
map("n", "<leader><space>", builtin.find_files, { desc = "Find files" })
map("n", "<leader>/", function()
	builtin.live_grep({
		additional_args = function()
			return { "--fixed-strings" }
		end,
	})
end, { desc = "Find content" })
map("n", "<leader>s", builtin.lsp_document_symbols, { desc = "Find document symbols" })
map("n", "<leader>S", builtin.lsp_dynamic_workspace_symbols, { desc = "Find workspace symbols" })
map("n", "<leader>e", builtin.diagnostics, { desc = "Find diagnostics" })
