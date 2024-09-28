return {
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
}
