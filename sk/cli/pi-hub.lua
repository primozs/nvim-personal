local hub = vim.fn.expand("~/.pi/harnesses/agent-hub/index.ts")

---@type sidekick.cli.Config
return {
  cmd = {
    "pi",
    "-e", vim.fn.expand("~/.pi/harnesses/damage-control/index.ts"),
    "-e", vim.fn.expand("~/.pi/harnesses/damage-control-continue/index.ts"),
    "-e", hub,
  },
  -- Distinguish pi-hub from plain pi when attaching to external/tmux sessions
  is_proc = function(_, proc)
    return proc.cmd:find("agent-hub", 1, true) ~= nil
  end,
  url = "https://github.com/badlogic/pi-mono",
  resume = { "--resume" },
  continue = { "--continue" },
  native_scroll = false,
}
