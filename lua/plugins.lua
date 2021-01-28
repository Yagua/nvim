-- On ly required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  -- TODO: Maybe handle windows better?
  if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
    return
  end

  local directory = string.format(
    '%s/site/pack/packer/opt/',
    vim.fn.stdpath('data')
  )

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    directory .. '/packer.nvim'
  ))

  print(out)
  print("Downloading packer.nvim...")
  print("( You'll need to restart now )")

  return
end

return require('packer').startup(function(use)

    -- INTELLISENSE
    use 'neoclide/coc.nvim'
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
    ---- ICONS
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    ---- AUTO PAIRS FOR '(' '[' '{'
    use 'jiangmiao/auto-pairs'
    ---- CLOSETAGS
    use 'alvan/vim-closetag'
    ---- THEMES
    --use 'DilanGMB/HorizonFork'
    use 'DilanGMB/ForkMaterial'
    use 'gruvbox-community/gruvbox'
    --use 'tjdevries/colorbuddy.vim'
    --use 'RishabhRD/nvim-rdark'
    ---- FINDER
    use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
    use 'junegunn/fzf.vim'
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
    ----OTHERS
    use 'https://github.com/kezhenxu94/vim-mysql-plugin.git'
    use 'aquach/vim-http-client'
    use 'yggdroot/indentline'
    use 'mfussenegger/nvim-jdtls'
    ---- RAINBOW BRACKETS
    use 'luochen1990/rainbow'
    ---- TREE
    use 'kyazdani42/nvim-tree.lua'
    ---- BUILT-IN LSP
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/plenary.nvim'
    use 'hrsh7th/nvim-compe'
    --use 'nvim-lua/completion-nvim'
    --use 'tjdevries/complextras.nvim'
    --use 'RishabhRD/nvim-lsputils'
    --use 'RishabhRD/popfix'
    ---- STATUS LINE
    use 'tjdevries/express_line.nvim'
    ----FIRENVIM
    --use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
    -- TREESITTER
    --use 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    --use 'nvim-treesitter/playground'
end)
