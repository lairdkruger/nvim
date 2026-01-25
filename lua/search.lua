vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
})

local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		-- Open files in the current window (not split)
		mappings = {
			i = {
				["<CR>"] = require("telescope.actions").select_default,
			},
			n = {
				["<CR>"] = require("telescope.actions").select_default,
			},
		},

		-- Ignore common noisy paths
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
			hidden = true, -- include dotfiles but still obey ignore patterns
		},
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Find Help" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>/", require("telescope.builtin").live_grep, { desc = "Find Content" })
vim.keymap.set("n", "<leader>s", builtin.lsp_document_symbols, { desc = "Find Document Symbols" })
vim.keymap.set("n", "<leader>S", builtin.lsp_dynamic_workspace_symbols, { desc = "Find Workspace Symbols" })
