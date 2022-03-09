local api = vim.api

local auto_groups = {
  jdtls_lsp = {
    autocmd = {
      {
        event = { "FileType", },
        pattern = { "java", },
        callback = require('yagua.lsp.lsp_config').setup_jdtls,
      },
    },
    opts = {
      clear = true,
    }
  },
  hgy_group = {
    autocmd = {
      {
        event = { "TextYankPost", },
        pattern = { "*", },
        command = "silent! lua vim.highlight.on_yank({timeout = 40})",
      },
    },
    opts = {
      clear = true,
    }
  }
}

for gp, conf in pairs(auto_groups) do
  local group = api.nvim_create_augroup(gp, conf.opts)

  for _, aucmd in pairs(conf.autocmd) do
    api.nvim_create_autocmd(aucmd.event, {
      pattern = aucmd.pattern,
      command = aucmd.command,
      callback = aucmd.callback,
      group = group
    })
  end
end
