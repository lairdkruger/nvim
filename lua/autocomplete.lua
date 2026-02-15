vim.pack.add({
  { src = "https://github.com/github/copilot.vim" },
  { src = "https://github.com/saghen/blink.cmp" },
})

require("blink.cmp").setup({})

vim.g.copilot_filetypes = {
  -- ["*"] = false, -- enable/disable autocomplete
}
