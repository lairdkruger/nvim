vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
})

-- Install parsers
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

-- Auto format on save using Neovim's built-in LSP client
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    vim.lsp.buf.format({ bufnr = args.buf, async = false })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(args)
    local ignored_filetypes = { "NvimTree", "TelescopePrompt", "TelescopeResults" }
    if vim.tbl_contains(ignored_filetypes, vim.bo[args.buf].filetype) then
      return
    end
    vim.cmd("syntax off")
    vim.treesitter.start(args.buf)
  end,
})
