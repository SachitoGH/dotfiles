---@type vim.lsp.Config
return {
  -- Work around vscode-html-language-service#227 for embedded CSS.
  settings = {
    css = {
      lint = {
        validProperties = {},
      },
    },
  },
}
