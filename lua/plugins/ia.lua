return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'zbirenbaum/copilot.lua',
      'nvim-telescope/telescope.nvim',
      "j-hui/fidget.nvim",

      'lalitmee/codecompanion-spinners.nvim',
    },
    config = function()
      local set_keymap = require('utils').set_keymap
      local companion = require('codecompanion')

      set_keymap({
        { 'n', '<leader>av', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'AI - Toggle' } },
        { 'n', '<leader>as', '<cmd>CodeCompanionInterrupt<cr>', { desc = 'AI - Stop' } },
        { { 'n', 'v' }, '<leader>aa', '<cmd>CodeCompanionActions<cr>', { desc = 'AI - Prompt actions' } },
        {
          'n',
          '<leader>ax',
          function()
            local chat = companion.last_chat()
            if chat then
              chat:reset()
            end
          end,
          { desc = 'AI - Reset' },
        },
        {
          { 'n', 'v' },
          '<leader>aq',
          function()
            vim.ui.input({
              prompt = 'AI Question> ',
            }, function(input)
              if input and input ~= '' then
                vim.cmd('CodeCompanionChat ' .. input)
              end
            end)
          end,
          { desc = 'AI - Question' },
        },
      })

      companion.setup({
        display = {
          chat = {
            intro_message = '',
            separator = '─',
            show_context = true,
            show_header_separator = false,
            show_settings = false,
            show_token_count = true,
            show_tools_processing = true,
            start_in_insert_mode = false,
          },
        },
        interactions = {
          chat = {
            roles = {
              llm = function(adapter)
                return adapter.formatted_name .. " (" .. adapter.schema.model.default .. ")"
              end,
              user = os.getenv('USER') or 'User',
            },
            adapter = {
              name = 'copilot',
              model = 'claude-opus-4.6',
            },
            keymaps = {
              send = {
                modes = { n = '<CR>', i = '<C-s>' },
                opts = {},
              },
              close = {
                modes = { n = 'q', i = '<M-c>' },
                opts = {},
              },
            },
          },
        },
        extensions = {
          spinner = {
            enabled = true,
            opts = {
              style = 'fidget',
            },
          },
        },
      })
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = {
      'Copilot',
    },
    event = 'InsertEnter',
    opts = {
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = '[[',
          jump_next = ']]',
          accept = '<CR>',
          refresh = 'gr',
          open = '<M-CR>',
        },
        layout = {
          position = 'bottom', -- | top | left | right
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 75,
        keymap = {
          accept = '<M-l>',
          accept_word = false,
          accept_line = false,
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ['.'] = false,
      },
      copilot_node_command = 'node', -- Node.js version must be > 18.x
      server_opts_overrides = {},
    },
  },
}
