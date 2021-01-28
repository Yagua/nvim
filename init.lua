vim.cmd [[packadd vimball]]

package.loaded['globals'] = nil
local globals_ok, msg = pcall(require, 'globals')
if not globals_ok then
    print("Failed to load globals:", msg)
end

local opt = vim.opt

--SETTINGS
opt.exrc           = true
opt.cursorline     = true
opt.showmatch      = true
opt.relativenumber = true
opt.number         = true
opt.showcmd        = true
opt.hidden         = true
opt.smartindent    = true
opt.smartcase      = true
opt.expandtab      = true
opt.undofile       = true
opt.incsearch      = true
opt.termguicolors  = true
opt.ruler          = true
opt.errorbells     = false
opt.hlsearch       = false
opt.wrap           = false
opt.swapfile       = false
opt.backup         = false
opt.showmode       = false
opt.re             = 0
opt.tabstop        = 4
opt.cmdheight      = 2
opt.sw             = 4
opt.shiftwidth     = 4
opt.scrolloff      = 8
opt.updatetime     = 50
opt.colorcolumn    = 80
opt.t_Co           = 256
opt.signcolumn     = 'yes'
opt.encoding       = 'utf-8'
opt.clipboard      = 'unnamedplus'
opt.completeopt    = 'menuone,noinsert,noselect'
opt.signcolumn     = 'yes'
opt.guicursor      = {'n-v-c:block-Cursor/lCursor','i-ci-ve:ver25-Cursor2'}
vim.cmd[[set shortmess+=c]]
vim.cmd[[syntax on]]

--COLORSCHEME SETTINGS
vim.cmd[[colorscheme vim-material]]
vim.cmd[[highlight Normal ctermbg=NONE]]
vim.cmd[[let g:material_style='oceanic']]
vim.cmd[[set background=dark]]

-- MODULES
require('lsp')
require('plugins')
require('autocommands')
require('custom')
require('statusline')
