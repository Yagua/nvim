local dap = require("dap")
local dappy = require('dap-python')

if not dap.adapters.python then
  dappy.setup('~/.virtualenvs/debugpy/bin/python')
end

local define_test_runner = function()
  if vim.loop.fs_stat("manage.py") then
    return "django"
  end
  return "unittest"
end

local test_method = function()
  return dappy.test_method({test_runner = define_test_runner()})
end

local test_class = function()
  return dappy.test_class({test_runner = define_test_runner()})
end

-- temparal
local run_tests = function(args)
  if not vim.loop.fs_stat("manage.py") then return "" end
  args = args or {}
  return function ()
    local test_config = {
      type = 'python',
      request = 'launch',
      name = 'Run tests',
      program = vim.fn.getcwd() .. '/manage.py',
      args = vim.list_extend({"test"}, args),
      console = "integratedTerminal"
    }
    dap.run(test_config)
  end
end

local options = { silent = true, buffer = 0 }
vim.keymap.set('n', '<leader>dn', test_method, options)
vim.keymap.set('n', '<leader>dN', function()
  local opts = {
    test_runner = define_test_runner(),
    config = {
      justMyCode = false,
    }
  }
  dappy.test_method(opts)
end, options)
vim.keymap.set('n', '<leader>df', test_class, options)
vim.keymap.set('v', '<leader>ds',
    '<ESC>:lua require("dap-python").debug_selection()<CR>', options)
vim.keymap.set('n', '<leader>rt', run_tests({"--keepdb"}), options)
vim.keymap.set('n', '<leader>rT', run_tests(), options)
