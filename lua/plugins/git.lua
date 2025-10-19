return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      watch_gitdir = { interval = 1000 },
      preview_config = {
        border = 'rounded',
        style = 'minimal',
      },
    },
    keys = {
      { '<leader>go', '<CMD>Gitsigns<CR>', silent = true },
      -- Actions
      { '<leader>fs', function() require('gitsigns').stage_hunk() end, desc = 'Git: Stage Hunk' },
      { '<leader>fr', function() require('gitsigns').reset_hunk() end, desc = 'Git: Reset Hunk' },
      { '<leader>hS', function() require('gitsigns').stage_buffer() end,    desc = 'Git: Stage Buffer' },
      { '<leader>hu', function() require('gitsigns').undo_stage_hunk() end, desc = 'Git: Undo Stage Hunk' },
      { '<leader>hR', function() require('gitsigns').reset_buffer() end,    desc = 'Git: Reset Buffer' },
      { '<leader>fi', function() require('gitsigns').preview_hunk() end,    desc = 'Git: Preview Hunk' },
      { '<leader>hb', function() require('gitsigns').blame_line({ full = true }) end, desc = 'Git: Blame Line' },
      { '<leader>tb', function() require('gitsigns').toggle_current_line_blame() end, desc = 'Git: Toggle Blame' },
      { '<leader>hd', function() require('gitsigns').diffthis() end, desc = 'Git: Diff This' },
      { '<leader>hD', function() require('gitsigns').diffthis('~') end, desc = 'Git: Diff This ~' },
      { '<leader>fd', function() require('gitsigns').toggle_deleted() end,  desc = 'Git: Toggle Deleted' },
      {
        '<leader>fs',
        function()
          require('gitsigns').stage_hunk({vim.fn.line("."), vim.fn.line("v")})
        end,
        mode = 'v',
        desc = 'Git: Stage Hunk (Visual)'
      },
      {
        '<leader>fr',
        function()
          require('gitsigns').reset_hunk({vim.fn.line("."), vim.fn.line("v")})
        end,
        mode = 'v',
        desc = 'Git: Reset Hunk (Visual)'
      },
      -- Text object
      { 'ih', ':<C-U>Gitsigns select_hunk<CR>', mode = { 'o', 'x' }, desc = 'Git: Select Hunk' },
      -- Navigation
      {
        ']c',
        function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() require('gitsigns').next_hunk() end)
          return '<Ignore>'
        end,
        expr = true,
        desc = 'Git: Next Hunk',
      },
      {
        '[c',
        function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() require('gitsigns').prev_hunk() end)
          return '<Ignore>'
        end,
        expr = true,
        desc = 'Git: Previous Hunk',
      },
    },
  },

  {
    'sindrets/diffview.nvim',
    config = true,
    keys = {
      {
        '<leader>gg',
        '<CMD>DiffviewOpen<CR>',
        desc = 'Diffview: Open',
        silent = true,
      },
      {
        '<leader>gh',
        '<CMD>DiffviewFileHistory<CR>',
        desc = 'Diffview: Open history',
        silent = true,
      },
      {
        '<leader>gq',
        '<CMD>DiffviewClose<CR>',
        desc = 'Diffview: Close',
        silent = true,
      },
    },
  },

  {
    'ThePrimeagen/git-worktree.nvim', -- TODO: Configure Git-worktree
    enabled = false,
    opts = {},
  },
}
