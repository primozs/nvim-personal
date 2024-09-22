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
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'windwp/nvim-autopairs',
    },
    opts = {},
  },

  -- lsp_signature.nvim [auto params help]
  -- https://github.com/ray-x/lsp_signature.nvim
  -- {
  --   'ray-x/lsp_signature.nvim',
  --   -- 'primozs/lsp_signature.nvim',
  --   event = "VeryLazy"
  -- },

  {
    'RishabhRD/nvim-cheat.sh',
    event = 'VeryLazy',
    dependencies = {
      'RishabhRD/popfix',
    },
    init = function()
      vim.g.cheat_default_window_layout = 'vertical_split'
      vim.keymap.set('n', '<leader>ch', '<cmd>Cheat<CR>', { noremap = true, silent = true })
    end,
  },

  --  compiler.nvim [compiler]
  --  https://github.com/zeioth/compiler.nvim
  {
    'primozs/compiler.nvim',
    branch = 'nim',
    -- "zeioth/compiler.nvim",
    -- https://lazy.folke.io/spec
    -- dir = "~/Documents/DEVELOPMENT/compiler.nvim",
    -- dev = true,
    cmd = {
      'CompilerOpen',
      'CompilerToggleResults',
      'CompilerRedo',
      'CompilerStop',
    },
    dependencies = { 'stevearc/overseer.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {},
    init = function()
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
    end,
  },

  --  overseer [task runner]
  --  https://github.com/stevearc/overseer.nvim
  --  If you need to close a task immediately:
  --  press ENTER in the output menu on the task you wanna close.
  {
    'stevearc/overseer.nvim',
    cmd = {
      'OverseerOpen',
      'OverseerClose',
      'OverseerToggle',
      'OverseerSaveBundle',
      'OverseerLoadBundle',
      'OverseerDeleteBundle',
      'OverseerRunCmd',
      'OverseerRun',
      'OverseerInfo',
      'OverseerBuild',
      'OverseerQuickAction',
      'OverseerTaskAction',
      'OverseerClearCache',
    },
    opts = {
      task_list = { -- the window that shows the results.
        direction = 'bottom',
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

  -- Run tests inside of nvim [unit testing]
  -- https://github.com/nvim-neotest/neotest
  -- https://github.com/vim-test/vim-test/
  { 'vim-test/vim-test' },

  -- https://github.com/folke/trouble.nvim
  -- {
  --   'folke/trouble.nvim',
  --   config = function()
  --     require('trouble').setup {
  --       icons = false,
  --     }

  --     vim.keymap.set('n', '<leader>tt', function()
  --       require('trouble').toggle()
  --     end)

  --     vim.keymap.set('n', '[t', function()
  --       require('trouble').next { skip_groups = true, jump = true }
  --     end,
  --     { desc = 'Previous trouble' })

  --     vim.keymap.set('n', ']t', function()
  --       require('trouble').previous { skip_groups = true, jump = true }
  --     end,
  --     { desc = 'Next trouble' })
  --   end,
  -- },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      harpoon:setup()

      -- basic telescope configuration
      -- local conf = require("telescope.config").values
      -- local function toggle_telescope(harpoon_files)
      --     local file_paths = {}
      --     for _, item in ipairs(harpoon_files.items) do
      --         table.insert(file_paths, item.value)
      --     end

      --     require("telescope.pickers").new({}, {
      --         prompt_title = "Harpoon",
      --         finder = require("telescope.finders").new_table({
      --             results = file_paths,
      --         }),
      --         previewer = conf.file_previewer({}),
      --         sorter = conf.generic_sorter({}),
      --     }):find()
      -- end

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Harpoon list add' })
      -- vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Harpoon open" })
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon open' })

      vim.keymap.set('n', '<S-H>', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon 1' })
      vim.keymap.set('n', '<S-J>', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon 2' })
      vim.keymap.set('n', '<S-K>', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon 3' })
      vim.keymap.set('n', '<S-L>', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon 4' })
      vim.keymap.set('n', '<leader><S-H>', function()
        harpoon:list():replace_at(1)
      end, { desc = 'Harpoon add 1' })
      vim.keymap.set('n', '<leader><S-J>', function()
        harpoon:list():replace_at(2)
      end, { desc = 'Harpoon add 2' })
      vim.keymap.set('n', '<leader><S-K>', function()
        harpoon:list():replace_at(3)
      end, { desc = 'Harpoon add 3' })
      vim.keymap.set('n', '<leader><S-L>', function()
        harpoon:list():replace_at(4)
      end, { desc = 'Harpoon add 4' })

      harpoon:extend {
        UI_CREATE = function(cx)
          vim.keymap.set('n', '<C-V>', function()
            harpoon.ui:select_menu_item { vsplit = true }
          end, { buffer = cx.bufnr })

          vim.keymap.set('n', '<C-S>', function()
            harpoon.ui:select_menu_item { split = true }
          end, { buffer = cx.bufnr })

          vim.keymap.set('n', '<C-t>', function()
            harpoon.ui:select_menu_item { tabedit = true }
          end, { buffer = cx.bufnr })
        end,
      }
    end,
  },

  -- {
  --   'mrcjkb/rustaceanvim',
  --   version = '^5', -- Recommended
  --   lazy = false, -- This plugin is already lazy
  -- }
}
