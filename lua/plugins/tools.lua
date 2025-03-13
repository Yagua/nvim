local set_keymap = require('utils').set_keymap
return {
  -- Toggleterm
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
      local dark_orange = vim.api.nvim_get_color_by_name('DarkOrange')
      require('toggleterm').setup(opts)

      --Term spawner
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

      -- Toggleterm keymaps
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

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    enabled = vim.fn.executable("yarn") == 1,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_command_for_global = 1
      vim.g.mkdp_combine_preview = 1

      local function load_then_exec(cmd)
        return function()
          vim.cmd.delcommand(cmd)
          require("lazy").load({ plugins = { "markdown-preview.nvim" } })
          vim.api.nvim_exec_autocmds("BufEnter", {}) -- commands appear only after BufEnter
          vim.cmd(cmd)
        end
      end

      ---Fixes "No command :MarkdownPreview"
      ---https://github.com/iamcco/markdown-preview.nvim/issues/585#issuecomment-1724859362
      for _, cmd in pairs({ "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" }) do
        vim.api.nvim_create_user_command(cmd, load_then_exec(cmd), {})
      end
    end,
  },

  -- Colorizer
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

  -- Harpoon
  {
    'ThePrimeagen/harpoon',
    event = 'VeryLazy',
    config = function()
      local hpm = require('harpoon.mark')
      local hpui = require('harpoon.ui')

      set_keymap({
        { 'n', '<leader>hm', hpui.toggle_quick_menu, { desc = 'Telescope: Harpoon marks' } },
        { 'n', '<leader>ha', hpm.add_file, { desc = 'Harpoon: Add file' } },
        { 'n', '<leader>hn', hpui.nav_prev, { desc = 'Harpoon: Previous file' } },
        { 'n', '<leader>hp', hpui.nav_next, { desc = 'Harpoon: Next file' } },
      })
    end,
  },

  -- Persistence.nvim
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

  -- Leap
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

  --Todo-comments
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

  -- Trouble.nivm
  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      {
        '<localleader>tt',
        '<CMD>TroubleToggle<CR>',
        desc = 'Trouble: Toggle',
        silent = true,
      },
    },
    opts = {
      position = 'top',
    },
  },

  -- Ssr.nvim
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

  -- Yanky.nvim
  {
    'gbprod/yanky.nvim',
    enabled = false,
    event = 'BufReadPost',
    config = function() end, -- TODO: Config Yanky
  },

  -- Undo tree
  {
    'mbbill/undotree',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      set_keymap({
        { 'n', '<leader>u', '<CMD>UndotreeShow<CR>', { desc = 'Undotree toggle' } },
      })
    end,
  },

  -- Maximizer
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
        java = {"cspell", "codespell"},
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

  -- db management
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      require("dbee").install("go")
    end,
    config = function()
      require("dbee").setup({
      })
    end,
  },

}
