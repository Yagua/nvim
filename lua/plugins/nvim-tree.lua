return {
  {
    'kyazdani42/nvim-tree.lua',
    keys = {
      { '<C-n>', '<CMD>NvimTreeToggle<CR>', silent = true },
    },
    opts = {
      update_cwd = true,
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      filters = { dotfiles = true },
      notify = { threshold = 5 },
      view = {
        number = true,
        adaptive_size = false,
        relativenumber = true,
      },
    },
    config = function(_, opts)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      local on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)
        -- Custom maps
        require('utils').set_keymap({
          { 'n', '?', api.tree.toggle_help, opts('Help') },
          { 'n', 'l', api.node.open.edit, opts('Edit') },
          { 'n', 'h', api.node.navigate.parent_close, opts('Close') },
          { 'n', '.', api.tree.toggle_hidden_filter, opts('Dotfiles') },
          { 'n', 'I', api.tree.toggle_gitignore_filter, opts('Ignore') },
        })
      end

      opts = vim.tbl_deep_extend('force', { on_attach = on_attach }, opts)
      require('nvim-tree').setup(opts)
    end,
  },
}
