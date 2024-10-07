return {
  {'JoosepAlviste/nvim-ts-context-commentstring',},
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()
      -- require('mini.comment').setup()
      require('mini.comment').setup {
        options = {
          custom_commentstring = function()
            return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
          end,
        },
      }

      -- // - mini.move (select blocks of text and move them up/down with `j`/`k`)
      -- //   - https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { 
        -- use_icons = vim.g.have_nerd_font 
        use_icons = true,
        set_vim_settings = true,
      }

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
    -- ts-comments.nvim [treesitter comments]
  -- https://github.com/folke/ts-comments.nvim
  -- This plugin can be safely removed after nvim 0.11 is released.
  {
    "folke/ts-comments.nvim",
     event = "User BaseFile",
    --  enabled = vim.fn.has("nvim-0.10.0") == 1,
     opts = {},
  },
  
}
