local cmp = require('cmp')
local lspkind = require('lspkind')

vim.cmd[[set shortmess+=c]] --  Don't pass messages to |ins-completion-menu|.
vim.opt.completeopt = { "menuone" , "noinsert", "noselect" }

cmp.setup {
  snippet = {
    expand = function(args)
      --vsnip
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  mapping = {
      ['<C-f>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = false
      },
    },
    sources = {
      { name = "nvim_lua" },
      { name = "path" },
      { name = "nvim_lsp", priority = 10 },
      { name = "buffer", priority = 2 },
      { name = "vsnip" },
      --{ name = "luasnip" }
    },
   formatting = {
     format = lspkind.cmp_format({
       with_text = true,
       menu = {
         buffer = "[buff]",
         nvim_lsp = "[LSP]",
         nvim_lua = "[api]",
         path = "[path]",
         vsnip = "[snip]",
         --luasnip = "[snip]",
       }
     })
   }
}
