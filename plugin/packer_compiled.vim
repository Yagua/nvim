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
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/home/dilanbar/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/dilanbar/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/dilanbar/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/dilanbar/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/dilanbar/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  ["colorbuddy.vim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/colorbuddy.vim"
  },
  ["cyclist.vim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/cyclist.vim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  ["express_line.nvim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/express_line.nvim"
  },
  ["formatter.nvim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/formatter.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  gruvbox = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["gruvbox-flat.nvim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/gruvbox-flat.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  nightbuddy = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/nightbuddy"
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
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  nvimdb = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/nvimdb"
  },
  onebuddy = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/onebuddy"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/popup.nvim"
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
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-maximizer"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-maximizer"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  vimspector = {
    loaded = true,
    path = "/home/dilanbar/.local/share/nvim/site/pack/packer/start/vimspector"
  }
}

time("Defining packer_plugins", false)
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
