local opt = vim.opt

--SETTINGS
opt.cursorline     = true          -- Highlight the current line
opt.showmatch      = true          -- show matching brackets when text indicator is over them
opt.relativenumber = true          -- Show line numbers
opt.number         = true          -- Show the actual number
opt.showcmd        = true          -- Show partial commands at the bottom of screen
opt.hidden         = true          -- Keep multiple buffers open
opt.smartindent    = true          -- Makes indenting smart
opt.expandtab      = true          -- Converts tabs to spaces
opt.undofile       = true          -- Reverse change in future sessions
opt.incsearch      = true          -- Make the search mode more convenient (like a browser)
opt.termguicolors  = true          -- Better color support (most terminal support this)
opt.hlsearch       = false         -- Disable permant highlight of searches
opt.wrap           = false         -- Don't wrap long lines
opt.swapfile       = false         -- Don't store changes in a swap file.
opt.backup         = false         -- Don't create backups files
opt.showmode       = false         -- Don't show the current mode
opt.tabstop        = 4             -- Number of spaces that a <Tab> in the file counts for
opt.softtabstop    = 4             -- Number of spaces that a <Tab> counts in <Tab> or <BS>.
opt.shiftwidth     = 4             -- Number of spaces to use for each step of (auto)indent.
opt.cmdheight      = 2             -- Height of the command bar
opt.scrolloff      = 10            -- Limit number of the scroll action
opt.updatetime     = 50            -- Make updates happen faster
opt.colorcolumn    = 80            -- Set a column for 80 characters
opt.signcolumn     = 'yes'         -- Always show the signcolumn
opt.clipboard      = ''            -- Copy paste between Vim and everything else
opt.guicursor      = {'n-v-c:block-Cursor/lCursor','i-ci-ve:ver25-Cursor2'} --Cursor settigs

--COLORSCHEME SETTINGS
vim.g.nb_style = "twilight"
require('colorbuddy').colorscheme('nightbuddy')
