-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

-- move buffer lines
-- map("n", "<C-H>", "<cmd>BufferLineMovePrev<CR>", { noremap = true })
-- map("n", "<C-L>", "<cmd>BufferLineMoveNext<CR>", { noremap = true })
vim.api.nvim_set_keymap(
  "n",
  "<A-h>",
  "<cmd>BufferLineMovePrev<CR>",
  { noremap = true, silent = true, desc = "Move tab left" }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-l>",
  "<cmd>BufferLineMoveNext<CR>",
  { noremap = true, silent = true, desc = "Move tab right" }
)

-- exit insert mode
map("i", "jk", "<ESC>", { noremap = true })

map("n", "gh", function()
  return vim.lsp.buf.hover()
end, { desc = "Hover" })

-- map visual block not working problem terminal is using ctrlv to paste
-- <C-V> works
-- map("n", "<C-v>", "<C-v>", { noremap = true, desc = "Visual Block mode" })

-- delete buffer
-- map("n", "<C-q>", ":bdelete<CR>", { noremap = true })
map("n", "<C-q>", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

map("t", "<C-n>", "<C-\\><C-N>", { noremap = true, silent = true, desc = "Terminal to normal mode" })
map("n", "<leader>cX", "<cmd>LspRestart<cr>", { noremap = true, desc = "Lsp restart" })

-- SI layout: / is Shift+7, so Ctrl+/ is awkward; bind Ctrl+7 like LazyVim's <C-/>
map({ "n", "t" }, "<C-7>", function()
  Snacks.terminal.focus(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })

-- Bash herdr-sessionizer (same as shell Ctrl+f). noice <c-f> disabled in
-- plugins/herdr-sessionizer.lua. Needs a real TTY for fzf — do not use silent
-- (silent :! has no TTY → herdr-sessionizer exits instantly). Snacks.terminal
-- gives a pty; auto_close when the CLI exits.
vim.schedule(function()
  vim.keymap.set("n", "<C-f>", function()
    Snacks.terminal({ "herdr-sessionizer" }, { auto_close = true, interactive = true })
  end, { desc = "herdr-sessionizer" })
end)
