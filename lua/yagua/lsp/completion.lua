local cmp = require('cmp')
local lspkind = require('lspkind')

-- vim.cmd[[set shortmess+=c]] --  Don't pass messages to |ins-completion-menu|.
vim.opt.completeopt = { "menu", "menuone", "noselect" }

cmp.setup {
  snippet = {
    expand = function(args)
      --vsnip
      require("luasnip").lsp_expand(args.body)
      -- vim.fn["vsnip#anonymous"](args.body)
    end
  },
  mapping = {
      ['<C-f>'] = cmp.mapping.scroll_docs(-2),
      ['<C-d>'] = cmp.mapping.scroll_docs(2),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = false
      },
    },
    sources = {
      { name = "nvim_lsp"},
      { name = "nvim_lua"},
      { name = "luasnip"},
      { name = "buffer", keyword_lenght = 5 },
      { name = "path"},
      -- { name = "vsnip"},
    },
   formatting = {
     format = lspkind.cmp_format({
       with_text = true,
       menu = {
         buffer = "[buff]",
         nvim_lsp = "[LSP]",
         nvim_lua = "[api]",
         path = "[path]",
         luasnip = "[snip]",
         -- vsnip = "[snip]",
       }
     })
   },
}
