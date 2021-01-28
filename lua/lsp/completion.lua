-- completion.nvim
--vim.g.completion_confirm_key = ""
--vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
--vim.g.completion_enable_snippet = 'UltiSnips'
--personal maps
--vim.api.nvim_set_keymap('i','<C-n>','<Plug>(completion_trigger)',{noremap = false, silent = true})
--vim.cmd[[ imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ? "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" : "\<CR>"]]


-- Decide on length
--vim.g.completion_trigger_keyword_length = 2

-- vim.g.completion_chain_complete_list = {
--   default = {
--     {
--       {complete_items = {'lsp', 'snippet'}},
--       {complete_items = {'buffer'}}, {mode = 'file'}
--     }
--   }
-- }

-- Complextras.nvim configuration
--vim.api.nvim_set_keymap(
  --'i',
  --'<C-x><C-m>',
  --[[<c-r>=luaeval("require('complextras').complete_matching_line()")<CR>]] --put comma
  --{ noremap = true, }
--)

--vim.api.nvim_set_keymap(
  --'i',
  --'<C-x><C-d>',
  --[[<c-r>=luaeval("require('complextras').complete_line_from_cwd()")<CR>]] --put comma
  --{ noremap = true, }
--)

local has_compe, compe = pcall(require, 'compe')
if has_compe then
  compe.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    allow_prefix_unmatch = false;

    source = {
      path = true;
      buffer = true;
      calc = true;
      vsnip = false;
      nvim_lsp = true;
      nvim_lua = true;
      spell = true;
      tags = false;
      ultisnips = true;
    };
  }
end
