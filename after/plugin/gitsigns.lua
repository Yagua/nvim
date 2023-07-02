require('gitsigns').setup {
  signs = {
    add =          { hl = "GitSignsAdd",    text = "│", numhl = "GitSignsAddNr" },
    change =       { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr" },
    delete =       { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr" },
    topdelete =    { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr" },
    changedelete = { hl = "GitSignsDelete", text = "~", numhl = "GitSignsChangeNr" },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>fs', gs.stage_hunk)
    map('n', '<leader>fr', gs.reset_hunk)
    map('v', '<leader>fs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', '<leader>fr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('n', '<leader>fS', gs.stage_buffer)
    map('n', '<leader>fu', gs.undo_stage_hunk)
    map('n', '<leader>fR', gs.reset_buffer)
    map('n', '<leader>fp', gs.preview_hunk)
    map('n', '<leader>fb', function() gs.blame_line{full=true} end)
    map('n', '<leader>ff', gs.toggle_current_line_blame)
    map('n', '<leader>fd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
}
