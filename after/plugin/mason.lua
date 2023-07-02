local mr = require("mason-registry")
local ensure_installed = {
  "debugpy",
  "python-lsp-server",
  "bash-language-server",
  "node-debug2-adapter",
  "java-test",
  "java-debug-adapter",
  "jdtls",
  "css-lsp",
  "html-lsp",
  "gopls",
  "json-lsp",
  "lua-language-server",
  "shfmt",
  "stylua",
  "taplo",
  "typescript-language-server",
  "vim-language-server",
  "yaml-language-server",
  "sqlfluff",
  "dockerfile-language-server",
  "docker-compose-language-service",
  "zls"
}
for _, tool in ipairs(ensure_installed) do
  local pack = mr.get_package(tool)
  if not pack:is_installed() then
    pack:install()
  end
end
