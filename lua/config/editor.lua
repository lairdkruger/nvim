-- lua/config/editor.lua

local M = {}

function M.setup()
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- Medium Jumps
  -- move by word
  map({ "n", "v" }, "<C-h>", "b", opts)
  map({ "n", "v" }, "<C-l>", "w", opts)
  -- move by block
  map({ "n", "v" }, "<C-j>", "}", opts)
  map({ "n", "v" }, "<C-k>", "{", opts)

  -- Large Jumps
  -- move to start/end of line
  map({ "n", "v" }, "H", "^", opts)
  map({ "n", "v" }, "L", "$", opts)
  -- move to top/bottom of file
  map({ "n", "v" }, "J", "G", opts)
  map({ "n", "v" }, "K", "gg", opts)

  -- Move lines
  map("n", "<M-j>", ":m+<CR>", opts)
  map("n", "<M-k>", ":m-2<CR>", opts)
  map("v", "<M-j>", ":m '>+1<CR>gv=gv", { silent = true })
  map("v", "<M-k>", ":m '<-2<CR>gv=gv", { silent = true })

  -- Select all
  map({ "n", "v" }, "<D-a>", "ggVG", opts)
end

function M.setup_multicursor()
  local mc = require("multicursor-nvim")
  mc.setup({})

  local set = vim.keymap.set

  -- Add and remove cursors with option + left click.
  set("n", "<M-leftmouse>", mc.handleMouse)
  set("n", "<M-leftdrag>", mc.handleMouseDrag)
  set("n", "<M-leftrelease>", mc.handleMouseRelease)

  -- Add a cursor for all matches of the current word or selection.
  -- This is an operator, so in normal mode it needs a motion (e.g., `<D-S-l>iw`).
  -- In visual mode, it works on the selection.
  set({ "n", "x" }, "<D-S-l>", mc.operator({ visual = true }))

  -- Add or skip cursor above/below the main cursor.
  set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
  set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)

  -- Customize how cursors look.
  local hl = vim.api.nvim_set_hl
  hl(0, "MultiCursorCursor", { reverse = true })
  hl(0, "MultiCursorVisual", { link = "Visual" })
end

return M
