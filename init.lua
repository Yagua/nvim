--[[

  .s5ss.
      SS. .s5SSSs.  .s5SSSs.  .s    s.  .s5SSSs.
  ssS SSS       SS.       SS.       SS.       SS.
  SSS SSS sS    S%S sS    `:; sS    S%S sS    S%S
   SSSSS  SSSs. S%S SS        SS    S%S SSSs. S%S
    SSS   SS    S%S SS  ''\   SS    S%S SS    S%S
    `:;   SS    `:; SS   ``:; SS    `:; SS    `:;
    ;,.   SS    ;,. SS    ;,. SS    ;,. SS    ;,.
    ;:'   :;    ;:' `:;;;;;:' `:;;;;;:' :;    ;:'

--]]

--Mapleader
vim.g.mapleader = " "

-- General Modules
require('yagua.plugins')
require('yagua.options')

--Lsp Modules
require('yagua.lsp')

--Telescope
require("yagua.telescope")

--dap
require("yagua.dap")
