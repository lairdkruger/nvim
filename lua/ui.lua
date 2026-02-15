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
    search = {},
    incsearch = {},
    keyword = {},
    types = {},
  },
  overrides = function(theme)
    return {
      -- highlight all search matches with bg = orange, fg = blue
      Visual = { bg = theme.surface2 },
      Search = { bg = theme.surface2 },
      IncSearch = { bg = theme.surface2 },
    }
  end,
})
vim.cmd([[colorscheme evergarden]])

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Status line
vim.o.laststatus = 3
vim.o.showtabline = 0 -- optional
vim.o.ruler = false

-- Cache git branch to avoid computing on every redraw
_G.cached_git_branch = ""
local function update_git_branch()
  local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD 2>/dev/null")[1]
  _G.cached_git_branch = branch and branch ~= "" and branch or ""
end

-- Update branch on buffer enter
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = update_git_branch,
})

-- Wrap cached branch in a function
_G.get_git_branch = function()
  return _G.cached_git_branch or ""
end

-- Statusline now calls the function
vim.o.statusline = "%f %y %m %= %{v:lua.get_git_branch()} %l:%c"

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

-- Terminal
local Term = {
  height = 12,
  bufs = { nil, nil },
  win_tag = "dual_term",
}

local function is_valid_buf(buf)
  return buf and vim.api.nvim_buf_is_valid(buf)
end

local function setup_term_buf(buf)
  vim.bo[buf].buflisted = false
  vim.bo[buf].swapfile = false
end

local function open_term(index)
  if not is_valid_buf(Term.bufs[index]) then
    vim.cmd("terminal")
    Term.bufs[index] = vim.api.nvim_get_current_buf()
    setup_term_buf(Term.bufs[index])
  else
    vim.api.nvim_set_current_buf(Term.bufs[index])
  end

  -- window-local UI tweaks
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.signcolumn = "no"

  -- tag the window
  vim.w[Term.win_tag] = true
end

local function terminal_windows()
  local wins = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.w[win][Term.win_tag] then
      table.insert(wins, win)
    end
  end
  return wins
end

local function open_terminal_pane()
  -- bottom container
  vim.cmd("botright split")
  vim.cmd("resize " .. Term.height)
  open_term(1)

  -- right terminal
  vim.cmd("vsplit")
  open_term(2)

  vim.cmd("startinsert")
end

local function close_terminal_pane()
  for _, win in ipairs(terminal_windows()) do
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end
end

local function toggle_terminal()
  if #terminal_windows() > 0 then
    close_terminal_pane()
  else
    open_terminal_pane()
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
