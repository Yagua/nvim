return {
  -- Notifications
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    keys = {
      {
        '<localleader>ns',
        '<CMD>Telescope notify<CR>',
        desc = 'Notify: Show notifications',
        silent = true,
      },
      {
        '<localleader>na',
        function()
          require('notify').dismiss({ silent = true, pending = true })
        end,
        desc = 'Notify: Delete all notifications',
        silent = true,
      },
    },
    opts = {
      timeout = 3000,
      stages = 'fade',
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    config = function(_, opts)
      local notify = require('notify')
      local colors = require("nebulous.colors").get_scheme("night")
      vim.notify = notify
      notify.setup(vim.tbl_extend("force", opts, {
        background_colour = colors.background
      }))
    end,
  },

  -- Vim-Illuminate
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      delay = 100,
      filetypes_denylist = {
        'NvimTree',
        'DiffviewFiles',
        'DiffviewFileHistory',
        'notify',
        'alpha',
        'lazy',
        'mason',
        'toggleterm',
      },
    },
    config = function(_, opts)
      local illuminate = require('illuminate')

      illuminate.configure(opts)
      local function map(key, dir, buffer)
        require('utils').set_keymap({
          {
            'n',
            key,
            function()
              illuminate['goto_' .. dir .. '_reference'](false)
            end,
            { desc = 'Iluminate: ' .. dir .. ' reference', buffer = buffer },
          },
        })
      end

      -- to avoid override
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map(']]', 'next', buffer)
          map('[[', 'prev', buffer)
        end,
      })
    end,
  },

  -- Ident guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    init = function()
      vim.opt.listchars:append({ tab = '│ ', trail = '𝁢' })
    end,
    opts = {
      indent = {
        char = '│',
        smart_indent_cap = true,
      },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
        },
      },
      scope = {
        enabled = false,
        show_end = false,
      },
      whitespace = {
        remove_blankline_trail = true,
      },
    },
  },

  {
    'echasnovski/mini.indentscope',
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
      -- To exclude indentscope where i dont want it to be
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    opts = {
      symbol = '│',
      options = { try_as_border = true },
    },
    config = function(_, opts)
      require('mini.indentscope').setup(opts)
    end,
  },

  -- Lsp servers' status spiner
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {
      progress = {
        display = {
          progress_icon = { pattern = 'bouncing_bar' },
        },
      },
    },
  },
}
