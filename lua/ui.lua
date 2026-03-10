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

-- Theme
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

-- Status line
vim.o.laststatus = 3
vim.o.showtabline = 0
vim.o.ruler = false

_G.cached_git_branch = ""
local function update_git_branch()
	local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD 2>/dev/null")[1]
	_G.cached_git_branch = branch and branch ~= "" and branch or ""
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = update_git_branch,
})

_G.get_git_branch = function()
	return _G.cached_git_branch or ""
end

vim.o.statusline = "%f %y %m %= %{v:lua.get_git_branch()} %l:%c"

-- File tree
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

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })

vim.api.nvim_create_autocmd("VimEnter", {
	desc = "Open nvim-tree on startup",
	group = vim.api.nvim_create_augroup("kickstart-nvim-tree-on-startup", { clear = true }),
	callback = function(args)
		if args.file == "" then
			vim.cmd("NvimTreeToggle")
		end
	end,
})

-- Utils
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
