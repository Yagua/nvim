local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print("Auto Installing Packer.nvim...")
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute('packadd packer.nvim')
end

return require('packer').startup ( function(use)

  local local_use = function(plug_path)
    if vim.fn.isdirectory(vim.fn.expand("~/Plugins/" .. plug_path)) == 1 then
      use("~/Plugins/" .. plug_path)
    else
      use(string.format('%s/%s', os.getenv("HOME"), plug_path))
    end
  end

  -- Local plugins
  local_use 'nvimdb'

  -- Plugin manager
  use 'wbthomason/packer.nvim'

  -- Better comments
  use 'scrooloose/nerdcommenter'

  -- Surround
  use 'tpope/vim-surround'

  -- Icons
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'
  use 'tjdevries/cyclist.vim'

  --Tabline
  use 'mkitt/tabline.vim'

  -- Closetags
  use 'alvan/vim-closetag'

  -- Themes
  local_use 'nebulous.nvim'
  use 'eddyekofo94/gruvbox-flat.nvim'
  use 'gruvbox-community/gruvbox'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{
      'nvim-lua/popup.nvim',
      'nvim-telescope/telescope-fzy-native.nvim'
    }}
  }

  -- Git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  -- Snippets
  use "rafamadriz/friendly-snippets"
  use "hrsh7th/vim-vsnip"

  -- Debugging
  use 'mfussenegger/nvim-dap'

  -- Utils
  use 'mhartington/formatter.nvim'
  use 'mbbill/undotree'
  use 'mhinz/vim-startify'
  use 'norcalli/nvim-colorizer.lua'
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'  }
  use 'szw/vim-maximizer'

  -- Tree
  use 'kyazdani42/nvim-tree.lua'

  -- Built-in lsp
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/plenary.nvim'
  use 'hrsh7th/nvim-compe'
  use 'mfussenegger/nvim-jdtls'
  use 'RishabhRD/popfix'
  use 'RishabhRD/nvim-lsputils'

  -- Status line
  use 'tjdevries/express_line.nvim'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() vim.cmd[[TSUpdate]] end
  }
  use 'nvim-treesitter/playground'

  -- LaTex
  use 'lervag/vimtex'

end)