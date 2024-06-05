return {
  -- LuaSnip
  {
    'L3MON4D3/LuaSnip',
    event = 'VeryLazy',
    build = 'make install_jsregexp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
    opts = {
      history = true,
      region_check_events = 'InsertEnter',
      delete_check_events = 'TextChanged,InsertLeave',
    },
    keys = {
      {
        '<A-TAB>',
        function()
          return require('luasnip').jumpable(1) and '<PLUG>luasnip-jump-next' or '<TAB>'
        end,
        expr = true,
        silent = true,
        mode = 'i',
      },
      {
        '<A-TAB>',
        function()
          require('luasnip').jump(1)
        end,
        silent = true,
        mode = 's',
      },
      {
        '<S-TAB>',
        function()
          require('luasnip').jump(-1)
        end,
        silent = true,
        mode = { 'i', 's' },
      },
    },
  },

  -- Cmp
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
    },
    opts = function()
      local cmp = require('cmp')
      local lk = require('lspkind')

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })

      return {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-f>'] = cmp.mapping.scroll_docs(-2),
          ['<C-d>'] = cmp.mapping.scroll_docs(2),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'nvim_lua' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'crates' },
        }),
        formatting = {
          format = lk.cmp_format({
            with_text = true,
            menu = {
              nvim_lsp = '[LSP]',
              luasnip = '[Snip]',
              nvim_lua = '[Api]',
              buffer = '[Buff]',
              path = '[Path]',
            },
          }),
        },
      }
    end,
  },

  -- Comment.nvim
  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    event = 'VeryLazy',
    opts = {
      pre_hook = function()
        vim.g.skip_ts_context_commentstring_module = true
        require('ts_context_commentstring').setup({ enable_autocmd = true })
        require('ts_context_commentstring.internal').update_commentstring({})
      end,
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
      })
    end
  }
}
