return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    commit = '5f68f070e4f7158517afc55f125a6f5ed1f7db47',
    opts = function()
      -- State symbols
      local symbols = { modified = ' [+]', readonly = ' [-]', unnamed = '[No Name]' }

      -- Helper functions
      local scape = function(fname)
        return fname:gsub('%%', '%%%%')
      end

      -- Format_filename formats the file names
      local format_filename = function()
        local fname = scape(vim.fn.expand('%:p'))

        -- Sanitizes and formats the Java package content names
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

      -- Format_tab_label sanitizes the Java package content names in the tabs
      local format_tab_label = function(fname)
        if vim.startswith(fname, '%') then
          local package = fname:match('[%l.?]+') or ''
          local class = fname:match('([%a.-*$]+).class') or ''
          fname = string.format('%s::%s', package, class)
        end
        return fname
      end

      -- Nick_or_dap_status shows either my nickname or DAP's status
      local nick_or_dap_status = function()
        local dap = require('dap')
        if dap.session() then
          return dap.status()
        end
        return 'Yagua'
      end

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
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            'branch',
            'diff',
            {
              'diagnostics',
              symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
            },
          },
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
        extensions = {
          'nvim-dap-ui',
          'nvim-tree',
        },
      }
    end,
  },
}
