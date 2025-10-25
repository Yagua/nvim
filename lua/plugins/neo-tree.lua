return {
  {
    lazy = false,
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
        {
          "<C-n>",
          function()
            require("neo-tree.command").execute({ toggle = true })
          end,
          desc = "Toggle NeoTree",
        },
        {
          "<leader>cw",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
          end,
          desc = "Toggle NeoTree (cwd)",
        },
        {
          "<leader>ge",
          function()
            require("neo-tree.command").execute({ source = "git_status", toggle = true })
          end,
          desc = "Git Explorer",
        },
    },
    opts = {
      event_handlers = {
        {
          event = "file_open_requested",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end
        },
      },
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      source_selector = { winbar = true, },
      default_component_configs = {
        container = {
          enable_character_fade = false,
        },
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
        },
        git_status = {
          symbols = {
            added = "󰐕",
            modified = "",
            deleted = "",
            renamed = "",
            untracked = "?",
            ignored = "",
            unstaged = "󰄱",
            staged = "󰱒",
            conflict = "",
          },
        },
      },
      window = {
        position = "left",
        width = 35,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["l"] = "open",
          ["<cr>"] = "open",
          ["<esc>"] = "cancel",
          ["P"] = {
            "toggle_preview",
            config = {
              use_float = false,
            },
          },
          ["<C-t>"] = "open_tabnew",
          ["S"] = "open_split",
          ["s"] = "open_vsplit",
          ["w"] = "open_with_window_picker",
          ["h"] = "close_node",
          ["H"] = "close_all_nodes",
          ["L"] = "expand_all_nodes",
          ["a"] = {
            "add",
            config = {
              show_path = "none",
            },
          },
          ["A"] = "add_directory",
          ["d"] = "delete",
          ["r"] = "rename",
          ["b"] = "rename_basename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy",
          ["m"] = "move",
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
          ["i"] = "show_file_details",
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_ignored = true,
          hide_hidden = true,
        },
        bind_to_cwd = false,
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        group_empty_dirs = false,
        use_libuv_file_watcher = true,
        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["/"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["#"] = "fuzzy_sorter",
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",
            ["o"] = {
              "show_help",
              nowait = false,
              config = { title = "Order by", prefix_key = "o" },
            },
            ["oc"] = { "order_by_created", nowait = false },
            ["od"] = { "order_by_diagnostics", nowait = false },
            ["og"] = { "order_by_git_status", nowait = false },
            ["om"] = { "order_by_modified", nowait = false },
            ["on"] = { "order_by_name", nowait = false },
            ["os"] = { "order_by_size", nowait = false },
            ["ot"] = { "order_by_type", nowait = false },
          },
          fuzzy_finder_mappings = {
            ["<down>"] = "move_cursor_down",
            ["<C-n>"] = "move_cursor_down",
            ["<up>"] = "move_cursor_up",
            ["<C-p>"] = "move_cursor_up",
            ["<esc>"] = "close",
            ["<S-CR>"] = "close_keep_filter",
            ["<C-CR>"] = "close_clear_filter",
            ["<C-w>"] = { "<C-S-w>", raw = true },
            {
              n = {
                ["j"] = "move_cursor_down",
                ["k"] = "move_cursor_up",
                ["<S-CR>"] = "close_keep_filter",
                ["<C-CR>"] = "close_clear_filter",
                ["<esc>"] = "close",
              }
            }
          },
        },
      }
    }
  }
}
