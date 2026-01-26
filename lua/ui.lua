vim.pack.add({
  { src = "https://codeberg.org/evergarden/nvim.git", name = "evergarden" },
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/folke/which-key.nvim",
})

-- Font: IosevkaTerm Nerd Font
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
_G.git_branch = function()
  local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD 2>/dev/null")[1]
  if branch == nil or branch == "" or branch == "HEAD" then
    return ""
  end
  return " " .. branch
end

vim.o.statusline = "%f %y %m %= %{v:lua.git_branch()} %l:%c"

-- File explorer
require("nvim-tree").setup({
  disable_netrw = true,
  sync_root_with_cwd = true,
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

-- Startup layout
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Initial buffer
    vim.cmd("enew") -- create a new empty buffer

    local api = require("nvim-tree.api")
    api.tree.open()

    -- Terminal
    vim.cmd("botright split") -- create a new split at the bottom
    vim.cmd("resize 15")      -- set height of terminal (15 lines)
    vim.cmd("terminal")       -- open terminal in that split

    -- Move focus back to main buffer
    vim.cmd("wincmd k") -- move cursor up to the buffer
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
