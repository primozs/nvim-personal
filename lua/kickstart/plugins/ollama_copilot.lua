return {
   "Faywyn/llama-copilot.nvim",
  requires = "nvim-lua/plenary.nvim",
  opts = {
    host = "grad7.mywire.org",
    port = "11434",
    model = "deepseek-coder-v2:latest",
    max_completion_size = -1, -- use -1 for limitless
    -- debug = false
  }
}
