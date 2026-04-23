-- LSP server installation
require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"astro",
		"cssls",
		"css_variables",
		"eslint",
		"graphql",
		"html",
		"rust_analyzer",
		"svelte",
		"ts_ls",
	},
})

-- Extend css_variables to more filetypes
vim.lsp.config("css_variables", {
	filetypes = { "css", "scss", "less", "html", "svelte", "astro" },
})

-- Enable all installed servers
local mason_lspconfig = require("mason-lspconfig")
for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
	vim.lsp.enable(server_name)
end

-- LSP keymaps (0.12 defaults: gra, grr, gri, grn, grt, grx, gO, K, gd, gD)
-- We override go-to actions to use Telescope for a better picker UI.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local telescope = require("telescope.builtin")
		local buf = event.buf

		vim.keymap.set("n", "gd", telescope.lsp_definitions, { buffer = buf, desc = "LSP: Go to definition" })
		vim.keymap.set("n", "grr", telescope.lsp_references, { buffer = buf, desc = "LSP: Go to references" })
		vim.keymap.set("n", "gri", telescope.lsp_implementations, { buffer = buf, desc = "LSP: Go to implementations" })
		vim.keymap.set(
			"n",
			"grt",
			telescope.lsp_type_definitions,
			{ buffer = buf, desc = "LSP: Go to type definition" }
		)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buf, desc = "LSP: Go to declaration" })
		-- grn (rename), gra (code action), grx (codelens), gO (doc symbols), K (hover)
		-- are provided by Neovim 0.12 defaults — no need to re-declare
	end,
})
