vim.pack.add({
  { src = "https://codeberg.org/evergarden/nvim.git", name = "evergarden" },
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/folke/which-key.nvim",
})

-- Font: IosevkaTerm Nerd Font
-- Colorscheme
require('evergarden').setup({
  theme = {
    variant = "fall",
  },
  style = {
    keyword = {},
    types = {},
  }
})
vim.cmd([[colorscheme evergarden]])

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Status line
vim.g.git_branch = ""
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  callback = function()
    local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD 2>/dev/null")[1]
    if branch == nil or branch == "" or branch == "HEAD" then
      vim.g.git_branch = ""
      return
    end
    vim.g.git_branch = " " .. branch
  end,
})

vim.o.statusline = "%f %y %m %= %{g:git_branch} %l:%c"

-- File explorer
-- https://github.com/nvim-tree/nvim-tree.lua
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
vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", { italic = true })

-- Terminal
_G.term_bufnr = nil

function open_terminal()
  vim.cmd("botright split") -- open split at bottom
  vim.cmd("resize 12")      -- set height
  vim.cmd("terminal")       -- open terminal
  local buf = vim.api.nvim_get_current_buf()
  _G.term_bufnr = buf       -- save buffer number

  vim.api.nvim_buf_set_option(buf, "number", false)
  vim.api.nvim_buf_set_option(buf, "relativenumber", false)
  vim.api.nvim_buf_set_option(buf, "signcolumn", "no")

  -- enter insert mode
  vim.cmd("startinsert")
end

local function toggle_terminal()
  if _G.term_bufnr and vim.api.nvim_buf_is_valid(_G.term_bufnr) then
    -- check if the terminal window is open
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == _G.term_bufnr then
        vim.api.nvim_win_close(win, true)
        return
      end
    end
    -- if terminal buffer exists but no window, open it again
    vim.cmd("botright split")
    vim.cmd("resize 12")
    vim.api.nvim_set_current_buf(_G.term_bufnr)
    vim.cmd("startinsert")
  else
    open_terminal()
  end
end

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move to left window from terminal" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move to below window from terminal" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move to above window from terminal" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right window from terminal" })
vim.keymap.set("n", "<leader>t", toggle_terminal, { desc = "Toggle terminal" })
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })

-- Startup: toggle nvim-tree
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Open nvim-tree on startup",
  group = vim.api.nvim_create_augroup("kickstart-nvim-tree-on-startup", { clear = true }),
  callback = function()
    require("nvim-tree.api").tree.open()
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
