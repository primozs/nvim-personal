
-- vim.g.tabby_server_url = "http://127.0.0.1:9090"
-- vim.g.tabby_node_binary = vim.fn.expand("~/.nvm/versions/node/v20.10.0/bin/node")
-- vim.g.tabby_trigger_mode = "manual"
-- vim.g.tabby_keybinding_accept = "<Tab>"
-- vim.g.tabby_keybinding_trigger_or_dismiss = "<C-l>"

return {
  {
    "TabbyML/vim-tabby",
    cmd = "Tabby",
    event = { "BufReadPost", "BufNewFile" },
    lazy = false, -- FIXME: cannot make it lazyload
    init = function()
      -- vim.g.tabby_server_url = "http://127.0.0.1:9090"
      vim.g.tabby_node_binary = vim.fn.expand("~/.nvm/versions/node/v20.10.0/bin/node")
      vim.g.tabby_trigger_mode = "manual"
      vim.g.tabby_keybinding_accept = "<Tab>" 
      vim.g.tabby_keybinding_trigger_or_dismiss = '<C-\\>'
    end,
    keys = {
      {
        "<leader>ta",
        function()
          if vim.g.tabby_trigger_mode == "manual" then
            vim.g.tabby_trigger_mode = "auto"
          else
            vim.g.tabby_trigger_mode = "manual"
          end
        end,
        desc = "Tabby toggle",
      },
    },
  },
}
