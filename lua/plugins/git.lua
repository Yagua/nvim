local set_keymap = require('utils').set_keymap
return {
  -- Gitsigns
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    keys = {
      { '<leader>go', '<CMD>Gitsigns<CR>', silent = true },
    },
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
      on_attach = function(bufnr)
        local gitsigns = package.loaded.gitsigns
        local opts = { expr = true, buffer = bufnr }
        set_keymap({
          -- Actions
          { 'n' , '<leader>fs', gitsigns.stage_hunk },
          { 'n' , '<leader>fr', gitsigns.reset_hunk },
          { 'v' , '<leader>fs', function()
              gitsigns.stage_hunk {
                vim.fn.line('.'), vim.fn.line('v')
              }
            end
          },
          { 'v' , '<leader>fr', function()
              gitsigns.reset_hunk {
                vim.fn.line('.'), vim.fn.line('v')
              }
            end
          },
          { 'n', '<leader>hS', gitsigns.stage_buffer },
          { 'n', '<leader>hu', gitsigns.undo_stage_hunk },
          { 'n', '<leader>hR', gitsigns.reset_buffer },
          { 'n', '<leader>fi', gitsigns.preview_hunk },
          {
            'n',
            '<leader>hb',
            function()
              gitsigns.blame_line({ full = true })
            end,
          },
          { 'n', '<leader>tb', gitsigns.toggle_current_line_blame },
          { 'n', '<leader>hd', gitsigns.diffthis },
          {
            'n',
            '<leader>hD',
            function()
              gitsigns.diffthis('~')
            end,
          },
          { 'n', '<leader>fd', gitsigns.toggle_deleted },
          -- Text object
          { { 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>' },
          -- Navigation
          {
            'n',
            ']c',
            function()
              if vim.wo.diff then
                return ']c'
              end
              vim.schedule(gitsigns.next_hunk)
              return '<Ignore>'
            end,
            opts,
          },
          {
            'n',
            '[c',
            function()
              if vim.wo.diff then
                return '[c'
              end
              vim.schedule(gitsigns.prev_hunk)
              return '<Ignore>'
            end,
            opts,
          },
        })
      end,
    },
  },

  -- Diffview
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

  -- Git-worktree
  {
    'ThePrimeagen/git-worktree.nvim', -- TODO: Configure Git-worktree
    enabled = false,
    opts = {},
  },
}
