local globals = {}

function globals.opts(opts_table)
  if next(opts_table) == nil then return end
  for k, v in pairs(opts_table) do
   vim.opt[k] = v
  end
end

function P(element)
  print(vim.inspect(element))
  return element
end

return globals
