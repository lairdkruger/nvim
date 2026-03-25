return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
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
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			vim.lsp.config("css_variables", {
				filetypes = { "css", "scss", "less", "html", "svelte", "astro" },
			})

			vim.diagnostic.config({
				severity_sort = true,
				float = { focusable = false, border = "rounded", source = "if_many" },
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
				},
			})

			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					vim.diagnostic.open_float(nil, { scope = "cursor" })
				end,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local telescope = require("telescope.builtin")
					vim.keymap.set("n", "gv", vim.lsp.buf.rename, { buffer = event.buf, desc = "LSP: Rename variable" })
					vim.keymap.set({ "n", "x" }, "ga", function()
						vim.lsp.buf.code_action({ apply = true })
					end, { buffer = event.buf, desc = "LSP: Code action" })
					vim.keymap.set(
						"n",
						"gd",
						telescope.lsp_definitions,
						{ buffer = event.buf, desc = "LSP: Go to definition" }
					)
					vim.keymap.set(
						"n",
						"gr",
						telescope.lsp_references,
						{ buffer = event.buf, desc = "LSP: Go to references" }
					)
					vim.keymap.set(
						"n",
						"gi",
						telescope.lsp_implementations,
						{ buffer = event.buf, desc = "LSP: Go to implementations" }
					)
					vim.keymap.set(
						"n",
						"gD",
						vim.lsp.buf.declaration,
						{ buffer = event.buf, desc = "LSP: Go to declaration" }
					)
					vim.keymap.set(
						"n",
						"gt",
						telescope.lsp_type_definitions,
						{ buffer = event.buf, desc = "LSP: Go to type definition" }
					)
					vim.keymap.set(
						"n",
						"K",
						vim.lsp.buf.hover,
						{ buffer = event.buf, desc = "LSP: Hover documentation" }
					)
				end,
			})

			-- Setup LSP servers
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")

			for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
				-- Neovim 0.11+ logic
				if vim.fn.has("nvim-0.11") == 1 then
					vim.lsp.config(server_name, { capabilities = capabilities })
					vim.lsp.enable(server_name)
				else
					-- Fallback for Neovim 0.10 and older
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end
			end
		end,
	},
}

