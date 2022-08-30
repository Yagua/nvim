require("toggleterm").setup {
  size = 13,
  open_mapping = [[<A-t>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  persist_mode = true,
  direction = 'horizontal',
  close_on_exit = true,
  shell = vim.o.shell,
  auto_scroll = true,
  winbar = {
    enabled = false,
    name_formatter = function(term)
      return term.name
    end
  },
}
