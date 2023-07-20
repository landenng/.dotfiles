-- Because 'mason', 'mason-lspconfig', and 'lspconfig' work together,
-- I keep all of them contained in one config file here rather
-- than separate like the rest of the plugins
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "pyright"
  }
})

-- Allows the user to get more info on items in the code
-- via keybinds as specified
local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

require("lspconfig").lua_ls.setup {
  on_attach = on_attach
}

require("lspconfig").pyright.setup {
  on_attach = on_attach
}
