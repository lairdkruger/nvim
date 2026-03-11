return {
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false, -- Add this line to disable lazy loading
		cmd = { "NvimTreeToggle", "NvimTreeOpen" },
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },
		},
		config = function()
			require("nvim-tree").setup({
				disable_netrw = true,
				sync_root_with_cwd = true,
				view = {
					signcolumn = "no",
				},
				renderer = {
					icons = {
						web_devicons = {
							file = {
								enable = true,
								color = false,
							},
							folder = {
								enable = false,
								color = false,
							},
						},
						git_placement = "after",
						show = {
							folder_arrow = false,
						},
					},
				},
				update_focused_file = {
					enable = true,
				},
				diagnostics = {
					enable = true,
					show_on_dirs = true,
				},
				modified = {
					enable = true,
				},
				filters = {
					git_ignored = false,
				},
				actions = {
					change_dir = {
						enable = false,
						restrict_above_cwd = true,
					},
				},
			})

			vim.api.nvim_create_autocmd("VimEnter", {
				desc = "Open nvim-tree on startup",
				group = vim.api.nvim_create_augroup("kickstart-nvim-tree-on-startup", { clear = true }),
				callback = function(args)
					if args.file == "" then
						vim.cmd("NvimTreeToggle")
					end
				end,
			})
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
	{
		"codeberg.org/evergarden/nvim",
		name = "evergarden",
		config = function()
			-- Syntax highlighting
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local filetype = args.match
					if filetype == "NvimTree" or filetype == "" then
						return
					end
					pcall(vim.treesitter.start)
				end,
			})

			require("evergarden").setup({
				theme = {
					variant = "fall",
				},
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
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	},
}
