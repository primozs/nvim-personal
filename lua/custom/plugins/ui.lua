return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      delay = function(ctx)
        return ctx.plugin and 0 or 1000
      end,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        -- { '<leader>g', group = 'Git', mode = { 'n', 'v' } },
      },
    },
    -- filter = function(mapping)
    --   print(mapping)
    --   -- example to exclude mappings without a description
    --   -- return mapping.desc and mapping.desc ~= ""
    --   return true
    -- end,
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -- Neo-tree is a Neovim plugin to browse the file system
  -- https://github.com/nvim-neo-tree/neo-tree.nvim

  {
    'nvim-neo-tree/neo-tree.nvim',
    version = "3.26",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
    },
  },

  {
    -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.    
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.opt.termguicolors = true
      vim.cmd.colorscheme 'tokyonight-night'
      --      vim.cmd.colorscheme 'tokyonight-moon'

      -- You can configure highlights by doing something like:
      -- vim.cmd.hi 'Comment gui=none'
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
  },

  -- { "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   lazy = false,
  --   setup = function()
  --     local mocha = require("catppuccin.palettes").get_palette "mocha"

  --     require("catppuccin").setup({
  --       flavour = "mocha",
  --       highlight_overrides = mocha,
  --       integrations = {
  --         cmp = true,
  --         gitsigns = true,
  --         nvimtree = true,
  --         treesitter = true,
  --         notify = false,
  --         mini = {
  --             enabled = true,
  --             indentscope_color = "",
  --         },
  --       }
  --     })    
  --     vim.cmd.colorscheme "catppuccin"      
  --   end,
  -- },

  --   https://github.com/nvie/vim-oceanic-next?tab=readme-ov-file
  -- {
  --   'mhartington/oceanic-next',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     vim.cmd.colorscheme 'OceanicNext'
  --   end,
  -- },

  -- {
  --   'olimorris/onedarkpro.nvim',
  --   priority = 1000, -- Ensure it loads first
  --   init = function()
  --     --vim.cmd.colorscheme 'onedark'
  --     --vim.cmd.colorscheme 'onedark_vivid'
  --     vim.cmd.colorscheme 'onedark_dark'

  --     -- You can configure highlights by doing something like:
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },

  -- https://github.com/navarasu/onedark.nvim?tab=readme-ov-file#default-configuration
  -- {
  --   'navarasu/onedark.nvim',
  --   priority = 1000, -- Ensure it loads first
  --   opts = {
  --     --      style = 'deep',
  --     -- style = 'darker',
  --     style = 'warmer',
  --     transparent = false,
  --   },
  --   init = function()
  --     vim.cmd.colorscheme 'onedark'
  --   end,
  -- },

  --  nvim-scrollbar [scrollbar]
  --  https://github.com/petertriho/nvim-scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = "BufEnter",
    opts = {
      handlers = {
        diagnostic = true,
        gitsigns = true, -- gitsigns integration (display hunks)
        ale = true,      -- lsp integration (display errors/warnings)
        search = false,  -- hlslens integration (display search result)
      },
      excluded_filetypes = {
        "cmp_docs",
        "cmp_menu",
        "noice",
        "prompt",
        "TelescopePrompt",
        "alpha",
      },
    },
  },

  --  UI icons [icons]
  --  https://github.com/nvim-tree/nvim-web-devicons
  {
    "nvim-tree/nvim-web-devicons",
    enabled = true,
    event = "User BaseDefered",
    opts = {
      override = {
        -- default_icon = {
        --   icon = require("base.utils").get_icon("DefaultFile"),
        --   name = "default"
        -- },
        deb = { icon = "", name = "Deb" },
        lock = { icon = "󰌾", name = "Lock" },
        mp3 = { icon = "󰎆", name = "Mp3" },
        mp4 = { icon = "", name = "Mp4" },
        out = { icon = "", name = "Out" },
        ["robots.txt"] = { icon = "󰚩", name = "Robots" },
        ttf = { icon = "", name = "TrueTypeFont" },
        rpm = { icon = "", name = "Rpm" },
        woff = { icon = "", name = "WebOpenFontFormat" },
        woff2 = { icon = "", name = "WebOpenFontFormat2" },
        xz = { icon = "", name = "Xz" },
        zip = { icon = "", name = "Zip" },
      },
    },
    config = function(_, opts)
      require("nvim-web-devicons").setup(opts)
    end
  },

  --  LSP icons [icons]
  --  https://github.com/onsails/lspkind.nvim
  -- {
  --   "onsails/lspkind.nvim"   
  -- },
  -- {
  --   'lambdalisue/vim-nerdfont'
  -- },

  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = { "kevinhwang91/promise-async" },
  --   opts = {
  --     -- preview = {
  --     --   mappings = {
  --     --     scrollB = "<C-b>",
  --     --     scrollF = "<C-f>",
  --     --     scrollU = "<C-u>",
  --     --     scrollD = "<C-d>",
  --     --   },
  --     -- },
  --     close_fold_kinds_for_ft = {
  --       default = {'imports', 'comment'},
  --       json = {'array'},
  --       c = {'comment', 'region'}
  --     },
  --     provider_selector = function(_, filetype, buftype)
  --       local ftMap = {
  --         vim = 'indent',
  --         python = {'indent'},
  --         git = ''
  --       }

  --       -- local function handleFallbackException(bufnr, err, providerName)
  --       --   if type(err) == "string" and err:match "UfoFallbackException" then
  --       --     return require("ufo").getFolds(bufnr, providerName)
  --       --   else
  --       --     return require("promise").reject(err)
  --       --   end
  --       -- end
  
  --       -- only use indent until a file is opened
  --       -- return (filetype == "" or buftype == "nofile") and "indent"
  --       --     or function(bufnr)
  --       --       return require("ufo")
  --       --           .getFolds(bufnr, "lsp")
  --       --           :catch(
  --       --             function(err)
  --       --               return handleFallbackException(bufnr, err, "treesitter")
  --       --             end
  --       --           )
  --       --           :catch(
  --       --             function(err)
  --       --               return handleFallbackException(bufnr, err, "indent")
  --       --             end
  --       --           )
  --       --     end
  --       -- return { "treesitter", "indent" }
  --       return ftMap[filetype] or {'treesitter', 'indent'}
  --     end,
  --   },
  --   config = function (_, opts)
  --     vim.opt.foldcolumn = "2"
  --     vim.opt.foldlevel = 2
  --     vim.opt.foldlevelstart = 20 -- Start with all code unfolded.
  --     vim.opt.foldenable = true
  --     vim.opt.foldnestmax = 2
  --     vim.opt.fillchars = { eob = " ", fold = " " ,foldopen = "▽" ,foldclose = "▷", foldsep="│"}

  --     vim.keymap.set('n', 'zR', function() require("ufo").openAllFolds() end, { desc = 'Open all folds' })
  --     vim.keymap.set('n', 'zM', function() require("ufo").closeAllFolds() end, { desc = 'Close all folds' })

  --     vim.keymap.set('n', 'zr', function() require("ufo").openFoldsExceptKinds() end, { desc = 'Fold less' })
  --     vim.keymap.set('n', 'zm', function() require("ufo").closeFoldsWith() end, { desc = 'Fold more' })

  --     vim.keymap.set('n', 'zp', function() require("ufo").peekFoldedLinesUnderCursor() end, { desc = 'Peek fold' })
  --     vim.keymap.set('n', 'zn', function() require("ufo").openFoldsExceptKinds({ 'comment' }) end, { desc = 'Fold comments' })
  --     vim.keymap.set('n', 'zN', function() require("ufo").openFoldsExceptKinds({ 'region' }) end, { desc = 'Fold region' })
  --     require('ufo').setup(opts)
  --   end,
  -- },

  { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags

    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
},
}
