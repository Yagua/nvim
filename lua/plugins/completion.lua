return {
  {
    'hrsh7th/nvim-cmp',
    lazy = false,
    priority = 100,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
    },
    config = function ()
      local cmp = require('cmp')
      local lk = require('lspkind')

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
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
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'nvim_lua' },
          { name = 'buffer' },
          { name = 'path' },
        }),
        formatting = {
          expandable_indicator = true,
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
      })
    end,
  },

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
        '<C-k>',
        function()
          require('luasnip').jump(1)
        end,
        silent = true,
        mode = { 'i', 's' },
      },
      {
        '<C-j>',
        function()
          require('luasnip').jump(-1)
        end,
        silent = true,
        mode = { 'i', 's' },
      },
    },
  },
}
