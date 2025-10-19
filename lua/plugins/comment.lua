return {
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
  }
}
