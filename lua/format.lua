vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/stevearc/conform.nvim",
})

require("nvim-treesitter").install({
  "astro",
  "bash",
  "c",
  "cpp",
  "css",
  "glsl",
  "go",
  "graphql",
  "grok",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "python",
  "rust",
  "scss",
  "sql",
  "svelte",
  "tsx",
  "typescript",
  "wgsl",
  "yaml",
  "zig",
  "zsh",
})

require("nvim-surround").setup()

require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    svelte = { "prettier" },
    astro = { "prettier" },
    json = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },
    python = { "black" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascript,typescript,javascriptreact,typescriptreact,svelte,astro,json,css,scss,html,python",
  callback = function(args)
    require("conform").format({ async = false, timeout_ms = 500 })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.ts,*.tsx,*.js,*.jsx",
  callback = function(args)
    require("conform").format({ async = false, timeout_ms = 500 })
  end,
})
