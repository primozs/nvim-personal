return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  
  { 'Bilal2453/luvit-meta', lazy = true },
  
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
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
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "windwp/nvim-autopairs"
    },
    opts = {}
  },

  -- lsp_signature.nvim [auto params help]
  -- https://github.com/ray-x/lsp_signature.nvim
  {
    "ray-x/lsp_signature.nvim",
    event = "BufEnter",
    opts = function()
      -- Apply globals from 1-options.lua
      local is_enabled = true
      local round_borders = {}
      round_borders = { border = 'rounded' }
      return {
        -- Window mode
        floating_window = is_enabled, -- Display it as floating window.
        hi_parameter = "IncSearch",   -- Color to highlight floating window.
        handler_opts = round_borders, -- Window style

        -- Hint mode
        hint_enable = false, -- Display it as hint.
        hint_prefix = "👈 ",

        -- Additionally, you can use <space>uH to toggle inlay hints.
        toggle_key_flip_floatwin_setting = is_enabled
      }
    end,
    config = function(_, opts) require('lsp_signature').setup(opts) end
  },

  {
    'RishabhRD/nvim-cheat.sh',
    event = 'VeryLazy',
    dependencies = {
      'RishabhRD/popfix',
    },
    init = function ()
      vim.g.cheat_default_window_layout = 'vertical_split'
      vim.keymap.set('n', '<leader>ch', '<cmd>Cheat<CR>', { noremap = true, silent = true })    
    end
  },

  --  compiler.nvim [compiler]
  --  https://github.com/zeioth/compiler.nvim
  {
    'primozs/compiler.nvim',
    branch = "nim",
    -- "zeioth/compiler.nvim",
    -- https://lazy.folke.io/spec
    -- dir = "~/Documents/DEVELOPMENT/compiler.nvim",
    -- dev = true,
    cmd = {
      "CompilerOpen",
      "CompilerToggleResults",
      "CompilerRedo",
      "CompilerStop"
    },
    dependencies = { 'stevearc/overseer.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {},
    init = function ()
        -- Open compiler
        vim.api.nvim_set_keymap('n', '<F6>', '<cmd>CompilerOpen<cr>', { noremap = true, silent = true })

        -- Redo last selected option
        vim.api.nvim_set_keymap(
          'n',
          '<S-F6>',
          '<cmd>CompilerStop<cr>' -- (Optional, to dispose all tasks before redo)
            .. '<cmd>CompilerRedo<cr>',
          { noremap = true, silent = true }
        )

        -- Toggle compiler results
        vim.api.nvim_set_keymap('n', '<S-F7>', '<cmd>CompilerToggleResults<cr>', { noremap = true, silent = true })      
    end
  },

  --  overseer [task runner]
  --  https://github.com/stevearc/overseer.nvim
  --  If you need to close a task immediately:
  --  press ENTER in the output menu on the task you wanna close.
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerSaveBundle",
      "OverseerLoadBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerRun",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
      "OverseerClearCache"
    },
    opts = {
     task_list = { -- the window that shows the results.
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
      -- component_aliases = {
      --   default = {
      --     -- Behaviors that will apply to all tasks.
      --     "on_exit_set_status",                   -- don't delete this one.
      --     "on_output_summarize",                  -- show last line on the list.
      --     "display_duration",                     -- display duration.
      --     "on_complete_notify",                   -- notify on task start.
      --     "open_output",                          -- focus last executed task.
      --     { "on_complete_dispose", timeout=300 }, -- dispose old tasks.
      --   },
      -- },
    },
  },

  --  TESTING -----------------------------------------------------------------
  --  Run tests inside of nvim [unit testing]
  --  https://github.com/nvim-neotest/neotest
  --
  --
  --  MANUAL:
  --  -- Unit testing:
  --  To tun an unit test you can run any of these commands:
  --
  --    :Neotest run      -- Runs the nearest test to the cursor.
  --    :Neotest stop     -- Stop the nearest test to the cursor.
  --    :Neotest run file -- Run all tests in the file.
  --
  --  -- E2e and Test Suite
  --  Normally you will prefer to open your e2e framework GUI outside of nvim.
  --  But you have the next commands in ../base/3-autocmds.lua:
  --
  --    :TestNodejs    -- Run all tests for this nodejs project.
  --    :TestNodejsE2e -- Run the e2e tests/suite for this nodejs project.
  -- 
  -- https://github.com/vim-test/vim-test/
  -- {
  --   "nvim-neotest/neotest",
  --   cmd = { "Neotest" },
  --   dependencies = {
  --     -- "sidlatau/neotest-dart",
  --     -- "Issafalcon/neotest-dotnet",
  --     "fredrikaverpil/neotest-golang",
  --     -- "rcasia/neotest-java",
  --     "nvim-neotest/neotest-jest",
  --     "nvim-neotest/neotest-python",
  --     "rouge8/neotest-rust",
  --     "nvim-neotest/neotest-plenary",
  --     "lawrence-laz/neotest-zig",
  --     "nvim-neotest/nvim-nio"
  --   },
  --   opts = function()
  --     return {
  --       -- your neotest config here
  --       adapters = {
  --         -- require("neotest-dart"),
  --         -- require("neotest-dotnet"),
  --         require("neotest-golang"),
  --         -- require("neotest-java"),
  --         require("neotest-jest"),
  --         require("neotest-python"),
  --         require("neotest-rust"),
  --         require("neotest-plenary"),
  --         require("neotest-zig"),
  --       },
  --     }
  --   end,
  --   config = function(_, opts)
  --     -- get neotest namespace (api call creates or returns namespace)
  --     local neotest_ns = vim.api.nvim_create_namespace "neotest"
  --     vim.diagnostic.config({
  --       virtual_text = {
  --         format = function(diagnostic)
  --           local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
  --           return message
  --         end,
  --       },
  --     }, neotest_ns)
  --     require("neotest").setup(opts)
  --   end,
  -- },
  {'vim-test/vim-test'}
}
