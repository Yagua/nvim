" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/dilanbar/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/dilanbar/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/dilanbar/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/dilanbar/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/dilanbar/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ForkMaterial = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/ForkMaterial"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  ["express_line.nvim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/express_line.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  indentline = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/indentline"
  },
  ["java-syntax.vim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/java-syntax.vim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-jdtls"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/nvim-jdtls"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lsputils"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/nvim-lsputils"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  popfix = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/popfix"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  rainbow = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/rainbow"
  },
  ["tabline.vim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/tabline.vim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  undotree = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-closetag"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-closetag"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-easymotion"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-js"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-js"
  },
  ["vim-jsx-pretty"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-jsx-pretty"
  },
  ["vim-maximizer"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-maximizer"
  },
  ["vim-mysql-plugin.git"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-mysql-plugin.git"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  vimspector = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vimspector"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
