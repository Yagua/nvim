return {
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
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>"
        },
        layout = {
          position = "bottom", -- | top | left | right
          ratio = 0.4
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 75,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
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
        ["."] = false,
      },
      copilot_node_command = 'node', -- Node.js version must be > 18.x
      server_opts_overrides = {},
    }
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    build = "make tiktoken", -- Only on MacOS or Linux
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      model = "claude-sonnet-4",
      headers = {
        user = "▶ " .. (os.getenv("USER") or "User") .. " ",
        assistant = '▶ Copilot ',
        tool = '▶ Tool ',
      },
      -- sticky = {
      --   '#buffers',
      -- },
      separator = '───',
      auto_follow_cursor = false,
      show_help = false,
      highlight_selection = false,
      prompts = {
        Explain = {
          mapping = '<leader>ae',
          description = 'AI Explain',
        },
        Review = {
          mapping = '<leader>ar',
          description = 'AI Review',
        },
        Tests = {
          mapping = '<leader>aT',
          description = 'AI Tests',
        },
        Fix = {
          mapping = '<leader>af',
          description = 'AI Fix',
        },
        Optimize = {
          mapping = '<leader>aO',
          description = 'AI Optimize',
        },
        Docs = {
          mapping = '<leader>ad',
          description = 'AI Documentation',
        },
      },
      mappings = {
        -- Close the chat
        close = {
          normal = "q",
          insert = "<M-c>",
        },
        -- Reset the chat buffer
        reset = {
          normal = "",
          insert = "",
        },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")
      local set_keymap = require('utils').set_keymap

      opts.prompts.Commit = {
        mapping = '<leader>aM',
        description = 'AI Generate Commit',
        selection = select.buffer
      }

      chat.setup(opts)

      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = "*", range = true })


      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      set_keymap({
        { 'n', "<leader>av", chat.toggle, { desc = "AI - Toggle" }},
        { 'n', "<leader>as", chat.stop, { desc = "AI - Stop" }},
        { 'n', "<leader>ax", chat.reset, { desc = "AI - Reset" }},
        { {'n', 'v'}, "<leader>aa", chat.select_prompt, { desc = "AI - Prompt actions" } },
        {
          {'n', 'v'},
          "<leader>aq",
          function()
            vim.ui.input({
              prompt = 'AI Question> ',
            }, function(input)
              if input ~= '' then
                chat.ask(input)
              end
            end)
          end,
          { desc = "AI - Question" }
        },
      })
    end,
  },
}
