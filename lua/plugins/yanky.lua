-- Keep yanky synced with the system clipboard even under SSH (we restore
-- clipboard in config/options.lua via local DISPLAY or OSC 52).
return {
  "gbprod/yanky.nvim",
  opts = {
    system_clipboard = {
      sync_with_ring = true,
    },
  },
}
