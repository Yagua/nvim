local ls = require("luasnip")
local vsc_load = require("luasnip.loaders.from_vscode").load

local function expand_paths(paths)
  if next(paths) == nil then return {} end

  local result = {}
  for _, v in pairs(paths) do
    result = vim.tbl_deep_extend(
      "force", result, vim.split(vim.fn.glob(
        string.format("%s**/*.json", v)), "\n")
    )
  end
  return result
end

vsc_load(expand_paths {
  "~/.local/share/nvim/site/pack/packer/start/friendly-snippets/snippets/",
  "~/.config/nvim/snips/",
})

vim.cmd[[
  imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
  inoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>

  imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
  smap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'

  snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(1)<CR>
  snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
]]
