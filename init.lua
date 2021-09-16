--[[

    ▓██   ██▓ ▄▄▄        ▄████  █    ██  ▄▄▄
     ▒██  ██▒▒████▄     ██▒ ▀█▒ ██  ▓██▒▒████▄
      ▒██ ██░▒██  ▀█▄  ▒██░▄▄▄░▓██  ▒██░▒██  ▀█▄
      ░ ▐██▓░░██▄▄▄▄██ ░▓█  ██▓▓▓█  ░██░░██▄▄▄▄██
      ░ ██▒▓░ ▓█   ▓██▒░▒▓███▀▒▒▒█████▓  ▓█   ▓██▒
       ██▒▒▒  ▒▒   ▓▒█░ ░▒   ▒ ░▒▓▒ ▒ ▒  ▒▒   ▓▒█░
     ▓██ ░▒░   ▒   ▒▒ ░  ░   ░ ░░▒░ ░ ░   ▒   ▒▒ ░
     ▒ ▒ ░░    ░   ▒   ░ ░   ░  ░░░ ░ ░   ░   ▒
     ░ ░           ░  ░      ░    ░           ░  ░
     ░ ░

--]]

--Mapleader
vim.g.mapleader = " "

-- General Modules
require('yagua.plugins')
require('yagua.options')
require('yagua.keymaps')

--Lsp Modules
require('yagua.lsp')

--Telescope
require("yagua.telescope")
