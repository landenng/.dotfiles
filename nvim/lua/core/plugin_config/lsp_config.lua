-- Because 'mason', 'mason-lspconfig', and 'lspconfig' work together,
-- I keep all of them contained in one config file here rather
-- than separate like the rest of the plugins
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "rust_analyzer",
    "lua_ls",
    -- "emmet_ls",
    -- "pyright",
    -- "sqlls",
    -- "clangd",
    -- "jdtls",
  }
})

-- Allows the user to get more info on items in the code
-- via keybinds as specified
local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  -- vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

-- For autocompletion and snippets
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local base_config = { 
    on_attach = on_attach,
    capabilities = capabilities
}

vim.lsp.config("rust-analyzer", base_config)
vim.lsp.config("lua_ls", base_config)
-- vim.lsp.config("clangd", base_config, { filetypes = { "c" } })
-- vim.lsp.config("emmet_ls", base_config, { filetypes = { "html", "css", "javascript" } })
-- vim.lsp.config("pyright", base_config, { filetypes = { "python" } })
-- vim.lsp.config("jdtls", base_config)


-- require("lspconfig").clangd.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = {"c"},
-- }
-- 
-- require("lspconfig").emmet_ls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = {"html", "css", "javascript"},
-- }
-- 
-- require("lspconfig").pyright.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = {"python"},
-- }
-- 
-- require("lspconfig").sqlls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities
-- }

-- require("lspconfig").jdtls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities
-- }
