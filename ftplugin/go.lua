vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

vim.keymap.set("n", "<space>td", function()
  require("dap-go").debug_test()
end, { buffer = 0 })
