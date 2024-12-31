return {
  -- Nvim-tree
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

  -- Lualine
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    commit = '5f68f070e4f7158517afc55f125a6f5ed1f7db47',
    opts = function()
      -- State symbols
      local symbols = { modified = ' [+]', readonly = ' [-]', unnamed = '[No Name]' }
      -- Helper functions
      local scape = function(fname)
        return fname:gsub('%%', '%%%%')
      end

      -- Format_filename formats the files names
      local format_filename = function()
        local fname = scape(vim.fn.expand('%:p'))
        local filetype = vim.fn.expand('%:e')

        -- Sanitizes and formats the java's packages contents names
        if vim.startswith(fname, 'jdt://') then
          local package = fname:match('contents/[%a%d.-]+/([%a%d.-]+)') or ''
          local class = fname:match('contents/[%a%d.-]+/[%a%d.-]+/([%a%d$]+).class') or ''
          fname = string.format('%s::%s', package, class)
        else
          fname = vim.fn.expand('%:~:.')
        end

        if fname ~= '' then
          if vim.bo.modified then
            fname = fname .. symbols.modified
          end
          if vim.bo.modifiable == false or vim.bo.readonly == true then
            fname = fname .. symbols.readonly
          end
        else
          fname = symbols.unnamed
        end
        return fname
      end

      -- Format_tab_label sanitizes the java's packages contents names in the tabs
      local format_tab_label = function(fname)
        if vim.startswith(fname, '%') then
          local package = fname:match('[%l.?]+') or ''
          local class = fname:match('([%a.-*$]+).class') or ''
          fname = string.format('%s::%s', package, class)
        end
        return fname
      end

      -- Nick_or_dap_status shows either my nick name or dap's status
      local nick_or_dap_status = function()
        local dap = require('dap')
        if dap.session() then
          return dap.status()
        end
        return 'Yagua'
      end

      -- Custom refresh for lualine's components
      -- this aucmd is created to complement the 'default_refresh_events'
      -- defined by lualine in the commit 5f68f070e4f7158517afc55f125a6f5ed1f7db47
      vim.api.nvim_create_autocmd({
        'BufWritePost',
        'CursorMoved',
        'CursorMovedI',
        'CursorHold',
        'CursorHoldI',
      }, {
        callback = function()
          require('lualine').refresh({
            kind = 'tabpage',
            place = { 'statusline', 'tabline', 'winbar' },
            trigger = 'autocmd',
          })
        end,
      })

      return {
        options = {
          theme = 'auto',
          disabled_filetypes = {
            statusline = { 'lazy', 'mason', 'alpha', 'notify' },
            winbar = {
              'NvimTree',
              'DiffviewFiles',
              'DiffviewFileHistory',
              'notify',
              'alpha',
              'lazy',
              'mason',
            },
          },
          ignore_focus = {},
          globalstatus = true,
          refresh = {
            statusline = 10,
            tabline = 10,
            winbar = 1,
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { format_filename },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        tabline = {
          lualine_a = {
            {
              'tabs',
              max_length = math.floor(vim.o.columns / 1.8),
              mode = 1,
              fmt = format_tab_label,
            },
          },
          lualine_z = { nick_or_dap_status },
        },
        inactive_winbar = {
          lualine_a = { format_filename, 'diagnostics' },
        },
        extensions = {
          'toggleterm',
          'nvim-dap-ui',
          'nvim-tree',
        },
      }
    end,
  },
}
