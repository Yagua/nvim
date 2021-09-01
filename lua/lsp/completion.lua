vim.cmd[[set shortmess+=c]] --  Don't pass messages to |ins-completion-menu|.
vim.opt.completeopt = { "menuone" , "noinsert", "noselect" }

local compe = require('compe')
local setmap = vim.api.nvim_set_keymap
local opts = {expr = true, silent = true, noremap = true}

compe.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = { --NOTE: in case of errors, change table to 'true'
    path = { kind = "" };
    buffer = { kind = "  (Buffer)" };
    calc = { kind = ";  (Calc)" };
    spell = { kind = "  (Spell)"},
    vsnip = { kind = "  (Snippet)" };
    nvim_lsp = true;
    nvim_lua = true;
    tags = false;
    ultisnips = false;
  };
}

vim.lsp.protocol.CompletionItemKind = {
    "  (Text)",
    "  (Method)",
    "  (Function)",
    "  (Constructor)",
    "ﴲ  (Field)",
    "  (Variable)",
    "  (Class)",
    "ﰮ  (Interface)",
    "  (Module)",
    "襁 (Property)",
    "  (Unit)",
    "  (Value)",
    "練 (Enum)",
    "  (Keyword)",
    "  (Snippet)",
    "  (Color)",
    "  (File)",
    "  (Reference)",
    "ﱮ  (Folder)",
    "  (EnumMember)",
    "  (Constant)",
    "  (Struct)",
    "  (Event)",
    "  (Operator)",
    "  (TypeParameter)"
}

setmap("i", "<CR>", "compe#confirm('<CR>')", opts )
setmap("i", "<C-Space>", "compe#complete()", opts )
setmap("i", "<C-e>", "compe#close('<C-e>')", opts )
setmap("i", "<C-d>", "compe#scroll({ 'delta': +4 })", opts )
setmap("i", "<C-f>", "compe#scroll({ 'delta': -4 })", opts )
--setmap("i", "<C-...>", "compe#close('<C-...>')", opts )
