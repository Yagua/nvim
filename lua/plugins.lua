local execute = vim.api.nvim_command
local path_install = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(path_install)) > 0 then
    print("Auto Installing Packer.nvim...")
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. path_install)
    execute('packadd packer.nvim')
end

return require('packer').startup(function(use)

    -- INTELLISENSE
    --use 'neoclide/coc.nvim'
    use 'wbthomason/packer.nvim'
    -- BETTER COMMENTS
    use 'scrooloose/nerdcommenter'
    ---- EASYMOTION
    use 'easymotion/vim-easymotion'
    ---- SURROUND
    use 'tpope/vim-surround'
    ---- BETTER SYNTAX SUPPORT
    use 'sheerun/vim-polyglot'
    use 'uiiaoo/java-syntax.vim'
    use 'yuezk/vim-js'
    use 'maxmellon/vim-jsx-pretty'
    ---- AUTO PAIRS
    use 'nvim-autopairs'
    --use 'jiangmiao/auto-pairs'
    ---- ICONS
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    --TABLINE
    use 'mkitt/tabline.vim'
    ---- CLOSETAGS
    use 'alvan/vim-closetag'
    ---- THEMES
    use 'DilanGMB/ForkMaterial'
    use 'gruvbox-community/gruvbox'
    --use 'tjdevries/colorbuddy.vim'
    --use 'DilanGMB/HorizonFork'
    --use 'RishabhRD/nvim-rdark'
    ---- FINDER
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{
         'nvim-lua/popup.nvim',
         'nvim-telescope/telescope-fzy-native.nvim'
      }}
    }
    ---- GIT
    use 'tpope/vim-fugitive'
    ----SNIPPETS
    use 'SirVer/ultisnips'
    use 'honza/vim-snippets'
    use 'mattn/emmet-vim'
    ---- UNDO TREE
    use 'mbbill/undotree'
    ---- COLORIZER
    use 'norcalli/nvim-colorizer.lua'
    ---- DEBUGGING
    use 'puremourning/vimspector'
    use 'szw/vim-maximizer'
    ----UTILS
    use 'vim-mysql-plugin.git'
    use 'yggdroot/indentline'
    use 'luochen1990/rainbow'
    ---- TREE
    use 'kyazdani42/nvim-tree.lua'
    ---- BUILT-IN LSP
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/plenary.nvim'
    use 'hrsh7th/nvim-compe'
    use 'onsails/lspkind-nvim'
    use 'RishabhRD/popfix'
    use 'RishabhRD/nvim-lsputils'
    use 'mfussenegger/nvim-jdtls'
    --use 'nvim-lua/completion-nvim'
    --use 'tjdevries/complextras.nvim'
    ---- STATUS LINE
    use 'tjdevries/express_line.nvim'
    -- TREESITTER
    --use 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    --use 'nvim-treesitter/playground'
    ----FIRENVIM
    --use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
end)
