local M = {}

M.save_and_exec = function()
  local ft = vim.bo.filetype
  vim.cmd("silent! write")
  if ft == 'vim' then
    vim.cmd("source %", {})
  elseif ft == 'lua' then
    vim.cmd("luafile %")
  end
end

local base_session_dir = vim.fn.expand("~/.local/state/nvim/sessions")
local session_file_name = "session.vim"
M.save_session = function()

  if vim.fn.isdirectory(base_session_dir) ~= 1 then
    vim.cmd(string.format("silent! !mkdir -p %s", base_session_dir))
  end
  vim.cmd("silent! write")
  vim.cmd(string.format("silent! mksession! %s/%s",
    base_session_dir, session_file_name))
end

M.load_session = function()
  local sf_path = string.format("%s/%s", base_session_dir, session_file_name)
  if vim.fn.filereadable(sf_path) ~= 1 then
    print("Session file not found")
    return
  end
  vim.cmd(string.format("so %s", sf_path))
end

return M
