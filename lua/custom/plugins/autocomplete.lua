-- Autocompletion
-- https://smarttech101.com/nvim-lsp-autocompletion-mapping-snippets-fuzzy-search/#formatting_in_nvimlsp_autocompletion

-- make your one for nimble
-- https://github.com/hrsh7th/cmp-path/tree/main
-- https://github.com/Snikimonkd/cmp-go-pkgs
-- https://www.jonashietala.se/blog/2024/05/26/autocomplete_with_nvim-cmp/
-- https://github.com/uga-rosa/cmp-dynamic

local kind_icons = {
  Class = "ﴯ",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "",
  Keyword = "",
  Method = "",
  Module = "",
  Operator = "",
  Property = "ﰠ",
  Reference = "",
  Snippet = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "",
}

return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          'rafamadriz/friendly-snippets',
          'zeioth/NormalSnippets',
          'benfowler/telescope-luasnip.nvim',
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
        opts = {
          history = true,
          delete_check_events = 'TextChanged',
          region_check_events = 'CursorMoved',
        },
        config = function(_, opts)
          if opts then
            require('luasnip').config.setup(opts)
          end

          vim.tbl_map(function(type)
            require('luasnip.loaders.from_' .. type).lazy_load()
          end, { 'vscode', 'snipmate', 'lua' })

          -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#loaders
          require("luasnip.loaders.from_vscode").load_standalone({
            language = "nim",
            path = "~/.config/nvim/snippets/nim.json"
          })

          -- friendly-snippets - enable standardized comments snippets
          require('luasnip').filetype_extend('typescript', { 'tsdoc' })
          require('luasnip').filetype_extend('javascript', { 'jsdoc' })
          require('luasnip').filetype_extend('lua', { 'luadoc' })
          require('luasnip').filetype_extend('python', { 'pydoc' })
          require('luasnip').filetype_extend('rust', { 'rustdoc' })
          require('luasnip').filetype_extend('cs', { 'csharpdoc' })
          require('luasnip').filetype_extend('java', { 'javadoc' })
          require('luasnip').filetype_extend('c', { 'cdoc' })
          require('luasnip').filetype_extend('cpp', { 'cppdoc' })
          require('luasnip').filetype_extend('kotlin', { 'kdoc' })
          require('luasnip').filetype_extend('sh', { 'shelldoc' })
        end,
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'f3fora/cmp-spell',
      -- 'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline'
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {        
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        
        formatting = {
          format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) --Concatonate the icons with name of the item-kind
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              spell = "[Spellings]",
              zsh = "[Zsh]",
              buffer = "[Buffer]",
              ultisnips = "[Snip]",
              treesitter = "[Treesitter]",
              calc = "[Calculator]",
              nvim_lua = "[Lua]",
              path = "[Path]",
              nvim_lsp_signature_help = "[Signature]",
              cmdline = "[Vim Command]"
            })[entry.source.name]
            return vim_item
          end,
        },

        matching = {
          disallow_fuzzy_matching = false,
        },

        completion = { 
          completeopt = 'menu,menuone,noinsert',
          keyword_length = 1,
        },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`    
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 'c'}),
          
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'c'}),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),

          ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          -- ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          ['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = cmp.config.sources( {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp', priority = 1000 },
          -- { name = 'nvim_lsp_signature_help', priority = 750 },
          { name = 'luasnip', priority = 750 },
          { name = 'buffer', priority = 500 },
          { name = 'path', priority = 250 }
        }),
      }

      -- cmp.setup.cmdline(':', {
      --   sources = cmp.config.sources({
      --     { name = 'path' },
      --     { name = 'cmdline' },
      --   })
      -- })

      -- cmp.setup.cmdline({'/', '?'}, {
      --   sources = {
      --     { name = 'buffer' },
      --   }
      -- })
    end,
  },
}
