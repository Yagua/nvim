local set_keymap = require('utils').set_keymap
return {
  "nvim-tree/nvim-web-devicons",

  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    version = '*',
    opts = {
      open_mapping = [[<A-t>]],
      shading_factor = 1,
      direction = 'horizontal'
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)

      local spawn_term = function(cmd, dir)
        require('toggleterm.terminal').Terminal
          :new({
            cmd = cmd,
            dir = dir or vim.fn.expand('%:p:h'),
            start_in_insert = true,
            close_on_exit = true,
          })
          :toggle()
      end

      set_keymap({
        {
          'n',
          '<localleader>gg',
          function()
            spawn_term('lazygit')
          end,
          { desc = 'Toggle Lazygit' },
        },
        {
          'n',
          '<localleader>gd',
          function()
            spawn_term('lazydocker')
          end,
          { desc = 'Toggle Lazydocker' },
        },
      })
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      filetypes = { '*', '!lazy' },
      buftype = { '*', '!prompt', '!nofile' },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = 'background', -- Set the display mode.
        virtualtext = '■',
      },
    },
  },

  {
    'folke/persistence.nvim',
    event = 'VeryLazy',
    config = function()
      local persistence = require('persistence')
      persistence.setup()
      set_keymap({
        -- restore the session for the current directory
        {
          'n',
          '<localleader>ls',
          persistence.load,
          { desc = 'Persistence: Restore current dir session' },
        },
        {
          'n',
          '<localleader>ll',
          function()
            persistence.load({ last = true })
          end,
          { desc = 'Persistence: Restore last session' },
        },
        {
          'n',
          '<localleader>ld',
          persistence.stop,
          { desc = 'Persistence: Stop persistence' },
        },
      })
    end,
  },

  {
    'ggandor/leap.nvim',
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap: forward to' },
      { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap: backward to' },
      { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap: from windows' },
    },
    config = function(_, opts)
      local leap = require('leap')
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ 'x', 'o' }, 'x')
      vim.keymap.del({ 'x', 'o' }, 'X')
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'BurntSushi/ripgrep',
    },
    keys = {
      {
        '<localleader>tc',
        '<CMD>TodoTelescope<CR>',
        desc = 'TODO Comments: All',
        silent = true,
      },
    },
    opts = {
      gui_style = {
        fg = 'NONE',
        bg = 'NONE',
      },
      highlight = {
        keyword = 'fg',
      },
    },
  },

  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {
    'cshuaimin/ssr.nvim',
    keys = {
      {
        '<localleader>s',
        function()
          require('ssr').open()
        end,
        desc = 'Structural replace',
        mode = { 'n', 'x' },
      },
    },
  },

  {
    'gbprod/yanky.nvim',
    enabled = false,
    event = 'BufReadPost',
    config = function() end, -- TODO: Config Yanky
  },

  {
    'mbbill/undotree',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      set_keymap({
        { 'n', '<leader>u', '<CMD>UndotreeShow<CR>', { desc = 'Undotree toggle' } },
      })
    end,
  },

  {
    'szw/vim-maximizer',
    keys = {
      {
        '<leader>ma',
        '<CMD>MaximizerToggle!<CR>',
        desc = 'Maximizer toggle',
        silent = true,
      },
    },
  },

  {
    'mfussenegger/nvim-lint',
    config = function (_)
      local lint = require('lint')
      local linters = require('lint').linters
      lint.linters_by_ft = {
        -- markdown = {'vale'},
        htmldjango = {'curlylint'},
        rst = {'vale'},
        -- java = {"cspell", "codespell"},
        lua = {'codespell', 'luacheck'},
        -- yaml = {'yamllint'},
        gitcommit = {'codespell'},
        dockerfile = {'hadolint'},
        ghaction = {"actionlint"},
        go = {"codespell" },
        ['yaml.ansible'] = {'ansible_lint'},
      }
      -- linters.codespell.args = {
      --   "--builtin=rare,informal,code,en-GB_to_en-US",
      -- }
    end
  },

  {
    'charm-and-friends/freeze.nvim',
    lazy = false,
    config = function(_)
      require('freeze').setup({
        command = "freeze",
        open = false,
        show_line_numbers = true,
        output = function()
          local res = vim.system({'uuidgen'}, { text = true }):wait()
          return os.getenv("HOME") .. "/Pictures/" .. res.stdout .. ".png"
        end,
        theme = "catppuccin-mocha",
      })
      set_keymap({
        { 'n', '<leader>fz', '<CMD>Freeze<CR>', { desc = 'Capture code image' } },
        { 'n', '<leader>fo', '<CMD>Freeze open<CR>', { desc = 'Open captured images' } },
      })
    end
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
      })
    end
  },

  {
    "hedyhli/outline.nvim",
    keys = {
      { "<leader>ol", "<cmd>Outline<cr>", desc = "Toggle Outline" }
    },
    cmd = "Outline",
    opts = function()
      local opts = {
        keymaps = {
          up_and_jump = "<up>",
          down_and_jump = "<down>",
        },
      }
      return opts
    end,
  }
}
