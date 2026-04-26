-- Treesitter
require("nvim-treesitter").setup()

-- Colorscheme
require("evergarden").setup({
	theme = { variant = "fall" },
	style = {
		search = {},
		incsearch = {},
		keyword = {},
		types = {},
	},
	overrides = function(theme)
		return {
			Visual = { bg = theme.surface2 },
			Search = { bg = theme.surface2 },
			IncSearch = { bg = theme.surface2 },
		}
	end,
})
vim.cmd([[colorscheme evergarden]])

-- File explorer
require("nvim-tree").setup({
	disable_netrw = true,
	sync_root_with_cwd = true,
	view = { signcolumn = "no" },
	renderer = {
		icons = {
			web_devicons = {
				file = { enable = true, color = false },
				folder = { enable = false, color = false },
			},
			git_placement = "after",
			show = { folder_arrow = false },
		},
	},
	update_focused_file = { enable = true },
	diagnostics = { enable = true, show_on_dirs = true },
	modified = { enable = true },
	filters = { git_ignored = false },
	actions = {
		change_dir = { enable = false, restrict_above_cwd = true },
	},
})

vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("nvim-tree-on-startup", { clear = true }),
	callback = function(args)
		if args.file == "" then
			vim.cmd("NvimTreeToggle")
		end
	end,
})

-- Buffer tabs
require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		offsets = {
			{
				filetype = "NvimTree",
				text = "",
				text_align = "left",
				separator = true,
			},
		},
		color_icons = false,
		show_buffer_icons = true,
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = true,
		always_show_bufferline = true,
	},
})

-- Keymap hints
require("which-key").setup({})
