-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_prettier_needs_config = true

-- LazyVim clears clipboard when SSH_CONNECTION is set so OSC 52 can take over.
-- This machine often has a local X11 session (:1) even when SSH_CONNECTION is
-- set (herdr / remote attach), so prefer xclip against that display. Fall back
-- to OSC 52 for true remote terminals.
local function detect_display()
  if vim.env.DISPLAY and vim.env.DISPLAY ~= "" then
    return vim.env.DISPLAY
  end
  local dir = "/tmp/.X11-unix"
  local handle = vim.uv.fs_scandir(dir)
  if not handle then
    return nil
  end
  while true do
    local name = vim.uv.fs_scandir_next(handle)
    if not name then
      break
    end
    local n = name:match("^X(%d+)$")
    if n then
      return ":" .. n
    end
  end
  return nil
end

local display = detect_display()
if display then
  vim.env.DISPLAY = display
  vim.opt.clipboard = "unnamedplus"
elseif vim.env.SSH_CONNECTION or vim.env.SSH_TTY then
  vim.opt.clipboard = "unnamedplus"
  local function paste()
    return {
      vim.fn.split(vim.fn.getreg(""), "\n"),
      vim.fn.getregtype(""),
    }
  end
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
  }
else
  vim.opt.clipboard = "unnamedplus"
end
