-- Yanking settings
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  callback = function()
    vim.highlight.on_yank({ timeout = 40 })
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost"}, {
  group = vim.api.nvim_create_augroup('lint', { clear = true }),
  callback = function() require("lint").try_lint() end,
})
