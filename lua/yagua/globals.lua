local globals = {}

globals.opts = function (opts_table)
  if next(opts_table) == nil then return end
  for k, v in pairs(opts_table) do
   vim.opt[k] = v
  end
end

P = function(arg)
  print(vim.inspect(arg))
  return arg
end

PP = function(...)
  local args = { ... }
  for _, arg in pairs(args) do
    print(vim.inspect(arg))
  end
  return args
end

R = function(name)
  RELOAD(name)
  return require(name)
end

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

return globals
