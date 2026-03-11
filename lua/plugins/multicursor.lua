return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
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
    -- set({ "n", "x" }, "<D-S-l>", mc.operator({ visual = true }))

    -- Add or skip cursor above/below the main cursor.
    set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
    set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
  end,
}
