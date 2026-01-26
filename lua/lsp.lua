vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

local lspconfig = require("lspconfig")

vim.lsp.enable({
	"lua_ls",
	"astro",
	"copilot",
	"css_variables",
	"cssls",
	"eslint",
	"graphql",
	"html",
	"rust_analyzer",
	"shopify_theme_ls",
	"svelte",
	"ts_ls",
})

-- Diagnostics configuration
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	} or {},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
})

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		-- LSP keymaps
		vim.keymap.set("n", "gv", vim.lsp.buf.rename, { buffer = event.buf, desc = "LSP: Rename variable" })
		vim.keymap.set({ "n", "x" }, "ga", vim.lsp.buf.code_action, { buffer = event.buf, desc = "LSP: Code action" })
		vim.keymap.set(
			"n",
			"gd",
			require("telescope.builtin").lsp_definitions,
			{ buffer = event.buf, desc = "LSP: Go to definition" }
		)
		vim.keymap.set(
			"n",
			"gr",
			require("telescope.builtin").lsp_references,
			{ buffer = event.buf, desc = "LSP: Go to references" }
		)
		vim.keymap.set(
			"n",
			"gi",
			require("telescope.builtin").lsp_implementations,
			{ buffer = event.buf, desc = "LSP: Go to implementations" }
		)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "LSP: Go to declaration" })
		vim.keymap.set(
			"n",
			"gt",
			require("telescope.builtin").lsp_type_definitions,
			{ buffer = event.buf, desc = "LSP: Go to type definition" }
		)
	end,
})
