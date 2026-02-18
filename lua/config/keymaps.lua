-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

-- move buffer lines
-- map("n", "<C-H>", "<cmd>BufferLineMovePrev<CR>", { noremap = true })
-- map("n", "<C-L>", "<cmd>BufferLineMoveNext<CR>", { noremap = true })

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
