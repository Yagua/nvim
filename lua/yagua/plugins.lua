local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print("Auto Installing Packer.nvim...")
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute('packadd packer.nvim')
end

return require('packer').startup(function(use)

  local local_use = function(plug)
    local root_path = vim.fn.expand("~/Plugins/")
    if vim.fn.isdirectory(root_path) ~= 1 then
      print(string.format(
        "Local plugin directory '%s' does not exists", root_path))
      return
    end
    if vim.fn.isdirectory(root_path .. plug) == 1 then
      use(root_path .. plug)
    else
      print(string.format(
        "Plugin '%s' does not exists in %s", plug, root_path))
    end
  end

  -- Local plugins
  local_use 'nvimdb'
  local_use 'nebulous.nvim'

  -- Plugin manager
  use 'wbthomason/packer.nvim'

  -- Better comments
  use 'numToStr/Comment.nvim'

  -- Surround
  use 'tpope/vim-surround'

  -- Icons
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'
  use 'tjdevries/cyclist.vim'
  use 'onsails/lspkind-nvim'

  --Tabline
  use 'mkitt/tabline.vim'

  -- Closetags
  use 'alvan/vim-closetag'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{
      'nvim-lua/popup.nvim',
      'nvim-telescope/telescope-fzy-native.nvim'
    }}
  }

  -- Git
  use {'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim'}
  use 'lewis6991/gitsigns.nvim'

  -- Snippets
  use 'rafamadriz/friendly-snippets'
  use 'hrsh7th/vim-vsnip'
  -- use 'L3MON4D3/LuaSnip'

  -- Debugging
  use 'mfussenegger/nvim-dap'
  use "mfussenegger/nvim-dap-python"
  -- use "rcarriga/nvim-dap-ui"
  -- use "theHamsta/nvim-dap-virtual-text"

  use 'jbyuki/one-small-step-for-vimkind'

  -- Utils
  use 'mhartington/formatter.nvim'
  use 'mbbill/undotree'
  use 'norcalli/nvim-colorizer.lua'
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'  }
  use 'szw/vim-maximizer'
  use 'rest-nvim/rest.nvim'

  -- Tree
  use 'kyazdani42/nvim-tree.lua'

  -- Built-in lsp
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/plenary.nvim'
  use 'mfussenegger/nvim-jdtls'

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-vsnip'
  -- use 'saadparwaiz1/cmp_luasnip'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() vim.cmd[[TSUpdate]] end
  }
  use 'nvim-treesitter/playground'

end)
