---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "typescript-language-server",
        "tailwindcss-language-server",
        "css-lsp",
        "html-lsp",
        "emmet-ls",
        "eslint-lsp",
        "stylua",
        "prettier",
        "eslint_d",
        "biome",
        "js-debug-adapter",
        "tree-sitter-cli",
      },
    },
  },
}
