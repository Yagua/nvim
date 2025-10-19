return {
  {
    'ThePrimeagen/harpoon',
    event = 'VeryLazy',
    config = function()
      local hpm = require('harpoon.mark')
      local hpui = require('harpoon.ui')

      require("utils").set_keymap({
        { 'n', '<leader>hm', hpui.toggle_quick_menu, { desc = 'Telescope: Harpoon marks' } },
        { 'n', '<leader>ha', hpm.add_file, { desc = 'Harpoon: Add file' } },
        { 'n', '<leader>hn', hpui.nav_prev, { desc = 'Harpoon: Previous file' } },
        { 'n', '<leader>hp', hpui.nav_next, { desc = 'Harpoon: Next file' } },
      })
    end,
  }
}
