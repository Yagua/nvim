vim.cmd[[set shortmess+=c]] --  Don't pass messages to |ins-completion-menu|.
vim.opt.completeopt = { "menuone" , "noinsert", "noselect" }

local compe = require('compe')
local setmap = vim.api.nvim_set_keymap

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
    nvim_lua = false;
    spell = true;
    tags = false;
    ultisnips = true;
    snippets_nvim = false;
  };
}

setmap("i", "<C-Space>", "compe#complete()", {expr = true, silent = true, noremap = true})
setmap("i", "<C-e>", "compe#close('<C-e>')", {expr = true, silent = true, noremap = true})
setmap("i", "<C-f>", "compe#scroll({ 'delta': +4 })", {expr = true, silent = true, noremap = true})
setmap("i", "<C-d>", "compe#scroll({ 'delta': -4 })", {expr = true, silent = true, noremap = true})
