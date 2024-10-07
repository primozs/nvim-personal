-- https://github.com/pmizio/typescript-tools.nvim

return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
    servers = {
      tsservercontext = {},
    },

    setup = {
      tsservercontext = function(_, opts)
        local neoconf = require("neoconf")
        local lspconfig = require("lspconfig")

        if neoconf.get("is-volar-project") then
          lspconfig["volar"].setup({
            server = opts,
            settings = {},
          })

          require("typescript-tools").setup({
            server = opts,
            settings = {
              tsserver_plugins = {
                "@vue/typescript-plugin",
              },
            },
            filetypes = {
              "javascript",
              "typescript",
              "vue",
            },
          })
        else
          require("typescript-tools").setup({
            server = opts,
          })
        end

        return true
      end,
    },

  },

  -- autopairs
  -- https://github.com/windwp/nvim-autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  -- nvim-ts-autotag [auto close html tags]
  -- https://github.com/windwp/nvim-ts-autotag
  -- Adds support for HTML tags to the plugin nvim-autopairs.
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'windwp/nvim-autopairs',
    },
    opts = {},
  }
}
