-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_prettier_needs_config = true

-- Clipboard routing:
-- - Local desktop: use the normal provider (xclip / wl-copy) against DISPLAY.
-- - SSH or Herdr: prefer OSC 52 copy so yanks reach the *attached client's*
--   clipboard. Herdr panes often inherit a stale local DISPLAY and never get
--   SSH_CONNECTION (env is frozen at server start), so DISPLAY must not win
--   over HERDR_ENV. Herdr does not answer OSC 52 paste queries — paste from
--   the unnamed register only, or the outer terminal's native paste.
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

local in_herdr = vim.env.HERDR_ENV == "1" or (vim.env.HERDR_PANE_ID or "") ~= ""
local in_ssh = vim.env.SSH_CONNECTION ~= nil or vim.env.SSH_TTY ~= nil
local display = detect_display()

local function use_osc52_copy_only()
  vim.opt.clipboard = "unnamedplus"
  local function paste()
    return {
      vim.fn.getreg('"', 1, true),
      vim.fn.getregtype('"'),
    }
  end
  vim.g.clipboard = {
    name = "OSC 52 copy-only",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
  }
end

if in_herdr or in_ssh then
  use_osc52_copy_only()
elseif display then
  vim.env.DISPLAY = display
  vim.opt.clipboard = "unnamedplus"
else
  vim.opt.clipboard = "unnamedplus"
end
