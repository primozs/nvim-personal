return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth', 

    -- Highlight todo, notes, etc in comments
  { 
    'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false }
  },
  {
    "cappyzawa/trim.nvim",
    event = "BufWrite",
    opts = {
      trim_on_write = true,
      trim_trailing = true,
      trim_last_line = false,
      trim_first_line = false,
      -- ft_blocklist = { "markdown", "text", "org", "tex", "asciidoc", "rst" },
      -- patterns = {[[%s/\(\n\n\)\n\+/\1/]]}, -- Only one consecutive bl
    },
  },

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
      require('mini.comment').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v:%L'
      -- end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  -- nvim-lightbulb [lightbulb for code actions]
  -- https://github.com/kosayoda/nvim-lightbulb
  -- Show a lightbulb where a code action is available
  {
    'kosayoda/nvim-lightbulb',
    enabled = true,
    event = "BufEnter",
    opts = {
      action_kinds = { -- show only for relevant code actions.
        "quickfix",
      },
      ignore = {
        ft = { "lua", "markdown" }, -- ignore filetypes with bad code actions.
      },
      autocmd = {
        enabled = true,
        updatetime = 100,
      },
      sign = { enabled = false },
      virtual_text = {
        enabled = true,
        text = "💡"
      }
    },
    config = function(_, opts) require("nvim-lightbulb").setup(opts) end
  },


  -- ts-comments.nvim [treesitter comments]
  -- https://github.com/folke/ts-comments.nvim
  -- This plugin can be safely removed after nvim 0.11 is released.
  {
    "folke/ts-comments.nvim",
     event = "User BaseFile",
     enabled = vim.fn.has("nvim-0.10.0") == 1,
     opts = {},
   },

   --  render-markdown.nvim [normal mode markdown]
  --  https://github.com/MeanderingProgrammer/render-markdown.nvim
  --  While on normal mode, markdown files will display highlights.
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { "markdown" },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      heading = {
        sign = false,
        icons = { ' ', ' ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        width = "block",
      },
      code = {
        sign = false,
        width = 'block', -- use 'language' if colorcolumn is important for you.
        right_pad = 1,
      },
      dash = {
        width = 79
      },
      pipe_table = {
        style = 'full', -- use 'normal' if colorcolumn is important for you.
      },
    },
  },

  -- nvim-java [java support]
  -- https://github.com/nvim-java/nvim-java
  -- Reliable jdtls support. Must go before mason-lspconfig and lsp-config.
  {
    "nvim-java/nvim-java",
    ft = { "java" },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
    opts = {
      notifications = {
        dap = false,
      },
      -- NOTE: One of these files must be in your project root directory.
      --       Otherwise the debugger will end in the wrong directory and fail.
      root_markers = {
        'settings.gradle',
        'settings.gradle.kts',
        'pom.xml',
        'build.gradle',
        'mvnw',
        'gradlew',
        'build.gradle',
        'build.gradle.kts',
        '.git',
      },
    },
  },

  -- LANGUAGE IMPROVEMENTS ----------------------------------------------------
  -- guttentags_plus [auto generate C/C++ tags]
  -- https://github.com/skywind3000/gutentags_plus
  -- This plugin is necessary for using <C-]> (go to ctag).
  {
    "skywind3000/gutentags_plus",
    ft = { "c", "cpp" },
    dependencies = { "ludovicchabant/vim-gutentags" },
    config = function()
      -- NOTE: On vimplugins we use config instead of opts.
      vim.g.gutentags_plus_nomap = 1
      vim.g.gutentags_resolve_symlinks = 1
      vim.g.gutentags_cache_dir = vim.fn.stdpath "cache" .. "/tags"
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Auto generate C/C++ tags",
        callback = function()
          local is_c = vim.bo.filetype == "c" or vim.bo.filetype == "cpp"
          if is_c then vim.g.gutentags_enabled = 1
          else vim.g.gutentags_enabled = 0 end
        end,
      })
    end,
  },
}
