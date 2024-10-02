--[[
    - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

   "<space>sh" to [s]earch the [h]elp documentation,
    :checkhealth` for more info.
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.opt.spelllang = 'en_us'
vim.opt.spell = true

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.opt.foldcolumn = '2'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99 -- Start with all code unfolded.
vim.opt.foldenable = true
vim.opt.foldnestmax = 2
vim.opt.fillchars = { eob = ' ', fold = ' ', foldopen = '▽', foldclose = '▷', foldsep = '│' }
vim.opt.foldmethod = 'indent'

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- https://github.com/neovim/neovim/pull/16600
vim.filetype.add({
  extension = {
    -- nimble = "txt",
    -- nims = "txt",
  },
})

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

vim.opt.colorcolumn = '80'

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<C-f>', '<cmd>!tmux neww tmux-sessionizer<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { noremap = true })
vim.keymap.set('n', '<C-q>', '<cmd>q<CR>', { noremap = true })
-- vim.keymap.set('n', '<C-q>', '<C-w>q', { noremap = true })
vim.keymap.set('n', '<leader>e', '<cmd>Vex<CR>', { noremap = true })
-- vim.keymap.set('n', '\\', '<cmd>Rexplore<CR>', { noremap = true })
vim.keymap.set('n', '<leader>vr', '<cmd>so ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<TAB>', '>>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-TAB>', '<<', { noremap = true, silent = true })
vim.keymap.set('v', '<TAB>', ">gv", { noremap = true, silent = true })
vim.keymap.set('v', '<S-TAB>', "<gv", { noremap = true, silent = true })
vim.keymap.set('i', '<S-TAB>', "<C-D>", { noremap = true, silent = true })

-- vim.keymap.set('x', '<C-I>', '<leader>f', { noremap = true, silent = true })
-- vim.keymap.set('x', '<C-A>', 'gcc', { noremap = true })

-- nnoremap <A-j> :m .+1<CR>==
-- nnoremap <A-k> :m .-2<CR>==
-- inoremap <A-j> <Esc>:m .+1<CR>==gi
-- inoremap <A-k> <Esc>:m .-2<CR>==gi
-- vnoremap <A-j> :m '>+1<CR>gv=gv
-- vnoremap <A-k> :m '<-2<CR>gv=gv
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })
vim.keymap.set({ 'n', 'v' }, 'gj', ':j<cr>', { desc = 'Join line' })
vim.keymap.set('n', '<leader>zig', '<cmd>LspRestart<cr>')

-- local get_lsp_client = function()
--   -- Get lsp client for current buffer
--   local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
--   local clients = vim.lsp.get_active_clients()
--   if next(clients) == nil then
--     return nil
--   end

--   for _, client in ipairs(clients) do
--     local filetypes = client.config.filetypes
--     if filetypes and vim.fn.index(filetypes,buf_ft) ~= -1 then
--       return client
--     end
--   end

--   return nil
-- end

-- vim.keymap.set('n', '<leader>zir', function()
--   local bufnr = vim.api.nvim_get_current_buf()
--   local client = get_lsp_client()
--   vim.lsp.buf_attach_client(bufnr, client)
-- end)

vim.keymap.set('x', '<leader>p', [["_dP]])
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
-- vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  command = 'silent! !setxkbmap -option caps:escape',
})

vim.api.nvim_create_autocmd('VimLeave', {
-- vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'silent! !setxkbmap -option',
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Detect tabstop and shiftwidth automatically
  -- 'tpope/vim-sleuth', 
  
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
    },
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

  -- LSP Plugins
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',
    },
    config = function()
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
          -- require("lsp_signature").on_attach({
          --   floating_window = true
          -- })

          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          vim.keymap.set('n', '<leader>zii', '<cmd>LspInfo<CR>', { buffer = event.buf, desc = 'LSP: info'})

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          map('gh', vim.lsp.buf.hover, 'Code hint')
          map('gs', vim.lsp.buf.signature_help, 'Signature help')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local utils = require('lspconfig').util
      local servers = {
        clangd = {},
        gopls = {},
        pyright = {},
        rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        ts_ls = {}, -- tsserver
        volar = {},
        -- https://github.com/nim-lang/langserver
        -- nimls = {
        --   -- filetypes = { 'nim' },
        --   -- root_dir = utils.root_pattern '*.nimble',
        --   -- settings = {
        --   --   nim = {
        --   --     nimsuggestPath = '~/.nimble/bin/nimsuggest',
        --   --   },
        --   -- },
        --   -- -- https://forum.nim-lang.org/t/10403
        --   -- capabilities = capabilities,  
        -- },
        nim_langserver = {
          -- filetypes = { 'nim' },
          -- root_dir = utils.root_pattern '*.nimble',
          -- settings = {
          --   nim = {
          --     nimsuggestPath = '~/.nimble/bin/nimsuggest',
          --   },
          -- },
          -- -- https://forum.nim-lang.org/t/10403
          -- capabilities = capabilities,
        },
        bashls = {},
        cmake = {},
        cssls = {},
        csharp_ls = {},
        css_variables = {},
        -- dartls = {},
        docker_compose_language_service = {},
        dockerls = {},
        emmet_language_server = {},
        -- eslint = {},
        gradle_ls = {},
        html = {},
        htmx = {},
        -- java_language_server = {},
        jinja_lsp = {},
        jsonls = {},
        kotlin_language_server = {},
        nginx_language_server = {},
        -- postgres_lsp = {},
        awk_ls = {},
        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    dependencies = {
      -- https://github.com/nvim-treesitter/nvim-treesitter-context
      'nvim-treesitter/nvim-treesitter-context',
    },
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    -- https://github.com/nvim-treesitter/nvim-treesitter/#adding-parsers
    -- https://github.com/alaviss/tree-sitter-nim
    -- init = function()
    --   local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
    --   parser_configs.nim = {
    --     install_info = {
    --       -- url = "https://github.com/alaviss/tree-sitter-nim.git",
    --       url = "~/.local/share/nvim/tree-sitter-nim-0.6.2",
    --       files = { "src/parser.c", "src/scanner.c" },
    --       -- files = { "src/parser.c" },
    --       branch = "main",
    --       -- generate_requires_npm = true, -- if stand-alone parser without npm dependencies
    --       -- requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
    --     },
    --     filetype = "nim",
    --   }
    -- end,
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'rust',
        'javascript',
        -- 'jsodoc',
        'typescript',
        'cpp',
        'go',
        'python',
        'nim',
        'nim_format_string',
        'css',
        'tsx',
        'json',
        'vue',
        'toml',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'markdown' },
        -- disable = {
        --   'nim', 'nimble', "nims"
        -- },
      },
      indent = {
        enable = true,
        disable = {
          -- 'ruby'
        },
      },
      context = { enable = true },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.nim',
  require 'kickstart.plugins.cloak',
  require 'kickstart.plugins.zenmode',
  require 'kickstart.plugins.vim_be_good',
  require 'kickstart.plugins.harpoon',
  require 'kickstart.plugins.trouble',
  require 'kickstart.plugins.telescope',
  require 'kickstart.plugins.tiny_diagnostics',
  require 'kickstart.plugins.scrollbar',
  require 'kickstart.plugins.neo_tree',
  require 'kickstart.plugins.which_key',
  require 'kickstart.plugins.web_dev_icons',
  require 'kickstart.plugins.mini',
  require 'kickstart.plugins.formatting',
  require 'kickstart.plugins.compile',
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.test',
  require 'kickstart.plugins.render_markdown',
  require 'kickstart.plugins.typescript',
  require 'kickstart.plugins.nvimlua',
  require 'kickstart.plugins.java',
  require 'kickstart.plugins.cheet',  
  require 'kickstart.plugins.undotree',

  require 'kickstart.plugins.tabby',
  require 'kickstart.plugins.gen',
  -- require 'kickstart.plugins.model',
  -- require 'kickstart.plugins.ollama_copilot',
  -- require 'kickstart.plugins.indent_line',


  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
